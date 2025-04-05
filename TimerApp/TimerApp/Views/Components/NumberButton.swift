import SwiftUI

struct NumberButton: View {
    let number: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(number)
                .font(.title2)
                .fontWeight(.medium)
                .frame(width: 60, height: 60)
                .background(
                    Circle()
                        .fill(Color.gray.opacity(0.1))
                )
                .foregroundColor(.white)
        }
    }
} 
