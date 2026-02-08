import SwiftUI

struct SettingsView: View {
    @AppStorage("notificationsEnabled") var notificationsEnabled = true

    @AppStorage("class1Title") var class1Title = ""
    @AppStorage("class1Room") var class1Room = ""
    @AppStorage("class2Title") var class2Title = ""
    @AppStorage("class2Room") var class2Room = ""
    @AppStorage("class3Title") var class3Title = ""
    @AppStorage("class3Room") var class3Room = ""
    @AppStorage("class4Title") var class4Title = ""
    @AppStorage("class4Room") var class4Room = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 30) {

            Text("Settings")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)

            Toggle("Enable Notifications", isOn: $notificationsEnabled)
                .tint(.white)
                .foregroundColor(.white)
                .onChange(of: notificationsEnabled) { newValue, _ in
                    if newValue {
                        NotificationManager.shared.scheduleMorningNotification(
                            class1Title: class1Title,
                            class1Room: class1Room,
                            class2Title: class2Title,
                            class2Room: class2Room
                        )
                        NotificationManager.shared.schedulePeriod2Notification(
                            class1Title: class1Title,
                            class1Room: class1Room,
                            class2Title: class2Title,
                            class2Room: class2Room
                        )
                        NotificationManager.shared.schedulePeriod3Notification(
                            class3Title: class3Title,
                            class3Room: class3Room,
                            class4Title: class4Title,
                            class4Room: class4Room
                        )
                        NotificationManager.shared.schedulePeriod4Notification(
                            class3Title: class3Title,
                            class3Room: class3Room,
                            class4Title: class4Title,
                            class4Room: class4Room
                        )
                    } else {
                        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    }
                }

            Button("Send Test Notification") {
                NotificationManager.shared.sendTestNotification()
            }
            .font(.headline)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(12)

            
            NavigationLink(destination: InfoView()) {
                Text("Info")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
            }

            Spacer()
        }
        .padding()
        .background(Color.black.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
