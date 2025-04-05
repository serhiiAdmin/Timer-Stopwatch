import SwiftUI

struct ModeSelector: View {
    @Binding var mode: Mode
    @Namespace private var namespace
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach([Mode.stopwatch, Mode.timer], id: \.self) { modeOption in
                Button(action: {
                    withAnimation(.spring()) {
                        mode = modeOption
                    }
                }) {
                    Text(modeOption == .stopwatch ? "Stopwatch" : "Timer")
                        .font(.system(.headline, design: .rounded))
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background {
                            if mode == modeOption {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(
                                        LinearGradient(
                                            colors: [Color.purple, Color.blue],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .matchedGeometryEffect(id: "ModeSelection", in: namespace)
                            }
                        }
                        .foregroundColor(mode == modeOption ? .white : .gray)
                }
            }
        }
        .padding(4)
        .background(Color.gray.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .padding(.horizontal)
        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
    }
} 
