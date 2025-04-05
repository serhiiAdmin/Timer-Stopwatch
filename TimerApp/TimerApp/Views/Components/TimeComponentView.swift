 
import SwiftUI

struct TimeComponentView: View {
    let value: Int
    let label: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Text(String(format: "%02d", value))
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                
                Text(label)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? Color.purple.opacity(0.2) : Color.gray.opacity(0.1))
            )
        }
    }
} 
