import Foundation

/**
 APIリクエストを管理し、取得した天気データをUIに提供する
 */
class WeatherViewModel: ObservableObject {
    @Published var weatherData: WeatherData?
    
    private let weatherService = WeatherAPIService()
    
    // 天気データを取得するメソッド
    func fetchWeather() {
        weatherService.getWeatherData { result in
            switch result {
            case .success(let weatherData):
                DispatchQueue.main.async {
                    self.weatherData = weatherData
                }
            case .failure(let error):
                print("Error fetching weather: \(error.localizedDescription)")
            }
        }
    }
}
