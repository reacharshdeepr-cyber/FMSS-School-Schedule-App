import SwiftUI

struct WelcomeScreen: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color.black.ignoresSafeArea()

                VStack(spacing: 20) {

                    Text("FMSS")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.top, 40)

                    Spacer()

                    VStack(spacing: 8) {
                        Text("School Day Calculator")
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)

                        Text("Arshdeep Rakhra")
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.7))
                            .padding(.top, 10)
                    }

                    Spacer()

                    Button(action: {
                        path.append("setup")
                    }) {
                        Text("Setup")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .padding(.horizontal, 40)
                    }
                    
                    Button(action: {
                        path.append("Info")
                    }) {
                        Text("Info")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .padding(.horizontal, 40)
                    }
                    
                    .padding(.bottom, 40)
                }
            }
            .navigationDestination(for: String.self) { value in
                if value == "setup" {
                    SetupView()
                } else if value == "Info" {
                    InfoView()
                }
            }

        }
    }
}

#Preview {
    WelcomeScreen()
}
