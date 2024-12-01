import SwiftUI

/// 天気情報カード
struct WeatherCard: View {
    var weather: WeatherData

    var body: some View {
        VStack {
            Text("現在地の天気")
                .font(.title2)
                .fontWeight(.bold)

            if let icon = weather.weather.first?.icon {
                WeatherIconView(icon: icon)
            }

            Text("\(weather.main.temp, specifier: "%.1f")°C")
                .font(.system(size: 50))
                .fontWeight(.heavy)
                .foregroundColor(.blue)

            Text(weather.weather.first?.description.capitalized ?? "情報なし")
                .font(.title3)
                .foregroundColor(.gray)

            Text("風速: \(weather.wind.speed, specifier: "%.1f") m/s")
                .font(.headline)
                .foregroundColor(.gray)
        }
        .padding(30)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.9))
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
        )
    }
}
