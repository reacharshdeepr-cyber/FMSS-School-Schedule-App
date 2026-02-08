import SwiftUI

struct ContentView: View {
    @AppStorage("hasCompletedSetup") var hasCompletedSetup = false

    var body: some View {
        if hasCompletedSetup {
            HomeView()
        } else {
            WelcomeScreen()
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
