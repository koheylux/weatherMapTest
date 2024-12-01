import SwiftUI

/// 天気情報を表示する View
struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()

    var body: some View {
        ZStack {
            // 背景グラデーション
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.white]),startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack {
                // 現在地取得ボタン
                Button(action: {
                    viewModel.fetchWeatherForCurrentLocation()
                }) {
                    Text("現在地の天気を取得")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.8))
                        .cornerRadius(10)
                }

                Spacer()

                // 天気データを表示
                if let weather = viewModel.weatherData {
                    WeatherCard(weather: weather, locationName: viewModel.locationName)
                } else {
                    Text("天気情報がありません")
                        .foregroundColor(.gray)
                }

                Spacer()
            }
            .padding()
        }
    }
}


struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
