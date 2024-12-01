import Foundation
import CoreLocation

/// 天気情報を管理する ViewModel
class WeatherViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var weatherData: WeatherData?
    @Published var locationName: String?

    private let weatherService = WeatherAPIService() // 天気APIサービス
    private let locationManager = CLLocationManager() // 位置情報マネージャ
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    /// 現在地を取得して天気を取得する
    func fetchWeatherForCurrentLocation() {
        // 現在の位置情報利用許可の状態を確認
        let status = locationManager.authorizationStatus
        switch status {
            case .notDetermined:
                // 許可がまだリクエストされていない場合、リクエストする
                locationManager.requestWhenInUseAuthorization()
            case .authorizedWhenInUse, .authorizedAlways:
                // 許可済みの場合、位置情報を取得開始
                locationManager.startUpdatingLocation()
            case .denied, .restricted:
                // 拒否された場合のエラーメッセージ
                print("位置情報の利用が許可されていません。")
            @unknown default:
                print("未知の許可状態: \(status.rawValue)")
        }
    }
    
    /// 位置情報が更新された際に呼ばれる
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 最後に取得した位置情報を使用
        guard let location = locations.last else { return }
        // 更新を停止してバッテリー消費を抑える
        locationManager.stopUpdatingLocation()
        // 取得した緯度・経度で天気情報を取得
        fetchWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        // 取得した緯度・経度で地点名を取得
        fetchLocationName(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    }
    
    /// 位置情報取得失敗時のハンドリング
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("位置情報の取得に失敗しました: \(error.localizedDescription)")
    }
    
    /// 天気データを取得
    private func fetchWeather(latitude: Double, longitude: Double) {
        weatherService.getWeatherData(latitude: latitude, longitude: longitude) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.weatherData = data
                case .failure(let error):
                    print("天気データ取得に失敗しました: \(error.localizedDescription)")
                }
            }
        }
    }

    private func fetchLocationName(latitude: Double, longitude: Double) {
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            if let error = error {
                print("地点名取得に失敗しました: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first {
                self?.locationName = placemark.locality ?? placemark.name
            }
        }
    }
}
