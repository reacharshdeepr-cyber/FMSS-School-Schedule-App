import SwiftUI

struct SetupView: View {

    // Permanent storage
    @AppStorage("class1Title") var class1Title = ""
    @AppStorage("class1Room") var class1Room = ""
    @AppStorage("class2Title") var class2Title = ""
    @AppStorage("class2Room") var class2Room = ""
    @AppStorage("class3Title") var class3Title = ""
    @AppStorage("class3Room") var class3Room = ""
    @AppStorage("class4Title") var class4Title = ""
    @AppStorage("class4Room") var class4Room = ""

    // Onboarding completion flag
    @AppStorage("hasCompletedSetup") var hasCompletedSetup = false

    // Local temporary values while typing
    @State private var t1 = ""
    @State private var r1 = ""
    @State private var t2 = ""
    @State private var r2 = ""
    @State private var t3 = ""
    @State private var r3 = ""
    @State private var t4 = ""
    @State private var r4 = ""

    // Navigation trigger
    @State private var goHome = false

    var allFieldsFilled: Bool {
        return !t1.isEmpty && !r1.isEmpty &&
               !t2.isEmpty && !r2.isEmpty &&
               !t3.isEmpty && !r3.isEmpty &&
               !t4.isEmpty && !r4.isEmpty
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                Text("Enter your course info in the order that appears on your schedule.")
                    .foregroundColor(.white)
                    .padding(.bottom, 10)

                Group {
                    classEntry(number: 1, title: $t1, room: $r1)
                    classEntry(number: 2, title: $t2, room: $r2)
                    classEntry(number: 3, title: $t3, room: $r3)
                    classEntry(number: 4, title: $t4, room: $r4)
                }

                Button(action: {
                    // Save permanently
                    class1Title = t1
                    class1Room = r1
                    class2Title = t2
                    class2Room = r2
                    class3Title = t3
                    class3Room = r3
                    class4Title = t4
                    class4Room = r4
                    
                    // Clear all past scheduled notifications
                    UNUserNotificationCenter.current( ).removeAllPendingNotificationRequests()
                    
                    // Schedule all of the Notifications
                    NotificationManager.shared.scheduleMorningNotification( class1Title: class1Title, class1Room: class1Room, class2Title: class2Title, class2Room: class2Room )
                    NotificationManager.shared.schedulePeriod2Notification(class1Title: class1Title, class1Room: class1Room, class2Title: class2Title, class2Room: class2Room)
                    NotificationManager.shared.schedulePeriod3Notification(class3Title: class3Title, class3Room: class3Room, class4Title: class4Title, class4Room: class4Room)
                    NotificationManager.shared.schedulePeriod4Notification(class3Title: class3Title, class3Room: class3Room, class4Title: class4Title, class4Room: class4Room)
                    
                    // Mark onboarding as complete
                    hasCompletedSetup = true

                    // Navigate to Home
                    goHome = true
                    
                    
                }) {
                    Text("Next")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(allFieldsFilled ? Color.white : Color.white.opacity(0.2))
                        .cornerRadius(12)
                }
                .disabled(!allFieldsFilled)
                .padding(.top, 20)
            }
            .padding()
        }
        .background(Color.black.ignoresSafeArea())
        .navigationDestination(isPresented: $goHome) {
            HomeView()
        }
    }

    // MARK: - Class Entry Component
    func classEntry(number: Int, title: Binding<String>, room: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Class \(number)")
                .foregroundColor(.white)
                .font(.headline)

            HStack {
                TextField("Title", text: title)
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: title.wrappedValue) {
                        if title.wrappedValue.count > 30 {
                            title.wrappedValue = String(title.wrappedValue.prefix(30))
                        }
                    }

                TextField("Room #", text: room)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                    .onChange(of: room.wrappedValue) { oldValue, newValue in
                        let filtered = newValue.filter { $0.isNumber }
                        room.wrappedValue = String(filtered.prefix(3))
                    }
                    .frame(width: 80)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SetupView()
    }
}

