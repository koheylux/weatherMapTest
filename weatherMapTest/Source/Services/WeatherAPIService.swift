import Foundation

/// 天気APIとの通信を管理するサービス
class WeatherAPIService {
    /// APIキーを `Keys.plist` から読み込む
    private var apiKey: String {
        guard let path = Bundle.main.path(forResource: "Keys", ofType: "plist"),
            let dictionary = NSDictionary(contentsOfFile: path),
            let key = dictionary["OpenWeatherMapAPIKey"] as? String else {
            fatalError("APIキーが見つかりません。Keys.plistファイルを確認してください。")
        }
        return key
    }
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather" // ベースURL
    
    /// 緯度・経度を使用して天気データを取得
    func getWeatherData(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        // APIのリクエストURLを作成
        let urlString = "\(baseURL)?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric&lang=ja"
        guard let url = URL(string: urlString) else { return }
        
        // ネットワークリクエスト
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            // JSONデータをデコード
            do {
                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                completion(.success(weatherData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}