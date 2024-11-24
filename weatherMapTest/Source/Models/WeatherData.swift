import Foundation

/**
 APIから取得するデータを格納するモデル
 */

// 天気データのルート構造体
struct WeatherData: Codable, Equatable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}

// 座標情報を保持する構造体
struct Coord: Codable, Equatable {
    let lon: Double
    let lat: Double
}

// 天気情報を保持する構造体
struct Weather: Codable, Equatable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

// 主な気象データを保持する構造体
struct Main: Codable, Equatable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

// 風情報を保持する構造体
struct Wind: Codable, Equatable {
    let speed: Double
    let deg: Int
}

// 雲情報を保持する構造体
struct Clouds: Codable, Equatable {
    let all: Int
}

// システム情報を保持する構造体
struct Sys: Codable, Equatable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}

