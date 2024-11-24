import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        ZStack {
            // 背景
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.white]),
                           startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            // コンテンツ
            if let weather = viewModel.weatherData {
                VStack {
                    Spacer() // 上部のスペースを埋める
                    
                    // カードスタイルの天気情報表示
                    WeatherCard(weather: weather)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white.opacity(0.9))
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                        )
                    
                    Spacer() // 下部のスペースを埋める
                }
                .padding()
                .animation(.easeInOut, value: viewModel.weatherData) // データ取得時のアニメーション
            } else {
                ProgressView("天気を取得中...")
                    .onAppear {
                        viewModel.fetchWeather()
                    }
                    .padding()
            }
        }
    }
}

struct WeatherCard: View {
    var weather: WeatherData
    
    var body: some View {
        VStack {
            Text("東京, 日本")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            if let icon = weather.weather.first?.icon {
                WeatherIconView(icon: icon)
                    .font(.system(size: 70)) // アイコンサイズ
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
