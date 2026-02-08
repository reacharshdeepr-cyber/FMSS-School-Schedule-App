import SwiftUI
import Foundation

struct InfoView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                // Header
                Text("About This App")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.bottom, 8)   // subtle separation

                // First paragraph
                Text("This app helps you calculate your school schedule quickly and easily. Simply copy and paste your class list, and it will generate a schedule for you!")
                    .font(.title3)
                    .foregroundColor(.white.opacity(0.85))

                // Second paragraph
                Text("Your daily schedule will automatically conform to the 2 day cycle we have here at Fletchers Meadow SS.")
                    .font(.title3)
                    .foregroundColor(.white.opacity(0.85))
                
                Text("You can also choose to receive notifications before every class which can help you get to class on time. Every time.")
                    .font(.title3)
                    .foregroundColor(.white.opacity(0.85))

                // Footer
                Spacer().frame(height: 80)

                Text("Feb 2026. Grade 9 MVP")
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.85))
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        InfoView()
    }
}
