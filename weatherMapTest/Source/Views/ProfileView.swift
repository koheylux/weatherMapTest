import SwiftUI

struct ProfileView: View {
    var body: some View {
        Text("プロフィール")
            .font(.largeTitle)
            .padding()
            .foregroundColor(.gray)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

