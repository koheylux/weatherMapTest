import SwiftUI

struct SettingsView: View {
    var body: some View {
        Text("設定画面")
            .font(.largeTitle)
            .padding()
            .foregroundColor(.gray)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
