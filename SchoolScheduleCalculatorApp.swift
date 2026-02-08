import SwiftUI

@main
struct SchoolScheduleCalculatorApp: App {

    init() {
        // Ask for notification permission as soon as the app launches
        NotificationManager.shared.requestPermission()
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
        }
    }
}

