import SwiftUI

/**
 アプリのメイン画面
 */
struct ContentView: View {
    var body: some View {
        TabView {
            // 天気画面
            WeatherView()
                .tabItem {
                    Label("Weather", systemImage: "cloud.sun")
                }
            
            // 設定画面
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
            
            // プロフィール画面
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
