import SwiftUI

/// 天気情報を表示する View
struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel() // ViewModelを使用
    
    var body: some View {
        ZStack {
            // 背景グラデーション
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.white]),
                           startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            // コンテンツ
            if let weather = viewModel.weatherData {
                VStack {
                    // 現在地取得ボタン
                    Button(action: {
                        viewModel.fetchWeatherForCurrentLocation()
                    }) {
                        Text("現在地の天気を取得")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    Spacer()
                    
                    // 天気データをカードで表示
                    WeatherCard(weather: weather)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white.opacity(0.9))
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                        )
                    
                    Spacer()
                }
                .padding()
            } else {
                // ローディング表示
                ProgressView("天気を取得中...")
                    .onAppear {
                        viewModel.fetchWeatherForCurrentLocation()
                    }
                    .padding()
            }
        }
    }
}

/// 天気情報カード
struct WeatherCard: View {
    var weather: WeatherData
    
    var body: some View {
        VStack {
            Text("現在地の天気")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            if let icon = weather.weather.first?.icon {
                WeatherIconView(icon: icon) // アイコン表示
            }
            
            Text("\(weather.main.temp, specifier: "%.1f")°C")
                .font(.system(size: 50))
                .fontWeight(.heavy)
                .foregroundColor(.blue)
            
            Text("体感温度: \(weather.main.feels_like, specifier: "%.1f")°C")
                .font(.headline)
                .foregroundColor(.gray)
            
            Text(weather.weather.first?.description.capitalized ?? "情報なし")
                .font(.title3)
                .foregroundColor(.gray)
            
            Text("風速: \(weather.wind.speed) m/s")
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.bottom, 20)
        }
        .padding()
    }
}

/// 天気アイコン表示用ビュー
struct WeatherIconView: View {
    let icon: String
    
    var body: some View {
        let iconURL = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        AsyncImage(url: URL(string: iconURL)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
        } placeholder: {
            ProgressView()
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
