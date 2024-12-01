import SwiftUI

/// 天気アイコンを表示するビュー
struct WeatherIconView: View {
    let icon: String

    var body: some View {
        // アイコンのURL
        let iconURL = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        AsyncImage(url: URL(string: iconURL)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
        } placeholder: {
            ProgressView()
        }
    }
}
