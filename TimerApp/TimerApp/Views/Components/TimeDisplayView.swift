import SwiftUI

struct TimeDisplayView: View {
    let timeElapsed: TimeInterval
    let mode: Mode
    
    var body: some View {
        VStack(spacing: 8) {
            Text(timeString(from: timeElapsed))
                .font(.system(size: 52, weight: .thin, design: .rounded))
                .foregroundColor(.white)
                .monospacedDigit()
                .padding(.horizontal, 24)
                .padding(.vertical, 40)
            
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.white.opacity(0.05))
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                )
                .shadow(color: .black.opacity(0.2), radius: 15, x: 0, y: 10)
            
            Text(mode == .stopwatch ? "Stopwatch" : "Timer")
                .font(.subheadline)
                .foregroundColor(.gray)
                .fontWeight(.medium)
        }
    }
    
    private func timeString(from timeInterval: TimeInterval) -> String {
        let hours = Int(timeInterval) / 3600
        let minutes = Int(timeInterval) / 60 % 60
        let seconds = Int(timeInterval) % 60
        let hundredths = Int((timeInterval.truncatingRemainder(dividingBy: 1) * 100))
        
        if mode == .timer || hours > 0 {
            return String(format: "%02d:%02d:%02d.%02d", hours, minutes, seconds, hundredths)
        } else {
            return String(format: "%02d:%02d.%02d", minutes, seconds, hundredths)
        }
    }
}
