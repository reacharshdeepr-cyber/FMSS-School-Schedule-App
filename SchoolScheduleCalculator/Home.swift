import SwiftUI

struct HomeView: View {

    // Stored class info
    @AppStorage("class1Title") var class1Title = ""
    @AppStorage("class1Room") var class1Room = ""
    @AppStorage("class2Title") var class2Title = ""
    @AppStorage("class2Room") var class2Room = ""
    @AppStorage("class3Title") var class3Title = ""
    @AppStorage("class3Room") var class3Room = ""
    @AppStorage("class4Title") var class4Title = ""
    @AppStorage("class4Room") var class4Room = ""

    @State private var path = NavigationPath()

    // MARK: - Day Rotation Logic
    var isDay1: Bool {
        let dayOfMonth = Calendar.current.component(.day, from: Date())
        return dayOfMonth % 2 == 1   // odd = Day 1, even = Day 2
    }

    var orderedClasses: [(title: String, room: String)] {
        if isDay1 {
            return [
                (class1Title, class1Room),
                (class2Title, class2Room),
                (class3Title, class3Room),
                (class4Title, class4Room)
            ]
        } else {
            return [
                (class2Title, class2Room),
                (class1Title, class1Room),
                (class4Title, class4Room),
                (class3Title, class3Room)
            ]
        }
    }

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color.black.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {

                        // Date + Day
                        VStack(alignment: .leading, spacing: 4) {
                            Text(Date.now.formatted(date: .long, time: .omitted))
                                .font(.title2)
                                .foregroundColor(.white)

                            Text(isDay1 ? "Day 1" : "Day 2")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                        }

                        // Classes
                        ForEach(0..<4) { index in
                            let classInfo = orderedClasses[index]

                            VStack(alignment: .leading, spacing: 6) {
                                Text("\(index + 1)")
                                    .font(.headline)
                                    .foregroundColor(.white)

                                Text(classInfo.title)
                                    .font(.title2)
                                    .foregroundColor(.white)

                                Text("Room \(classInfo.room)")
                                    .foregroundColor(.white.opacity(0.7))
                            }
                        }

                        // Re-enter button
                        Button {
                            path.append("setup")
                        } label: {
                            Text("Re-enter Classes")
                                .font(.headline)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                        }
                        .padding(.top, 20)

                        // Settings button
                        Button {
                            path.append("settings")
                        } label: {
                            Text("Settings")
                                .font(.headline)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                        }
                    }
                    .padding()
                }
            }
            .navigationDestination(for: String.self) { value in
                if value == "setup" {
                    SetupView()
                } else if value == "settings" {
                    SettingsView()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
