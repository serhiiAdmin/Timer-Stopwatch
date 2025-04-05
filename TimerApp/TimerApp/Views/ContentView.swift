//
//  ContentView.swift
//  TimerApp
//
//

import SwiftUI

struct ContentView: View {
    @State private var timeElapsed: TimeInterval = 0
    @State private var selectedTime: TimeInterval = 60
    @State private var timer: Timer?
    @State private var isRunning = false
    @State private var mode: Mode = .stopwatch
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            // Enhanced gradient background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "1A1A1A"),
                    Color(hex: "0A0A0A")
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            // Decorative circles in background
            GeometryReader { geometry in
                Circle()
                    .fill(Color.purple.opacity(0.1))
                    .blur(radius: 60)
                    .offset(x: -geometry.size.width * 0.5, y: -geometry.size.height * 0.2)
                
                Circle()
                    .fill(Color.blue.opacity(0.1))
                    .blur(radius: 60)
                    .offset(x: geometry.size.width * 0.4, y: geometry.size.height * 0.4)
            }
            
            MainContentView(
                timeElapsed: $timeElapsed,
                selectedTime: Binding(
                    get: { selectedTime },
                    set: { newValue in
                        selectedTime = newValue
                        // Update timeElapsed when selectedTime changes in timer mode
                        if mode == .timer && !isRunning {
                            timeElapsed = newValue
                        }
                    }
                ),
                isRunning: $isRunning,
                mode: $mode,
                startTimer: startTimer,
                stopTimer: stopTimer,
                resetTimer: resetTimer
            )
        }
        .preferredColorScheme(.dark)
        .onChange(of: mode) { _ in
            resetTimer()
        }
    }
    
    private func startTimer() {
        isRunning = true
        if mode == .timer {
            if timeElapsed == 0 {
                timeElapsed = selectedTime
            }
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                if timeElapsed > 0 {
                    timeElapsed -= 0.01
                } else {
                    stopTimer()
                }
            }
        } else {
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                timeElapsed += 0.01
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        isRunning = false
    }
    
    private func resetTimer() {
        stopTimer()
        timeElapsed = mode == .timer ? selectedTime : 0
    }
    
    private func timeString(from timeInterval: TimeInterval) -> String {
        let hours = Int(timeInterval) / 3600
        let minutes = Int(timeInterval) / 60 % 60
        let seconds = Int(timeInterval) % 60
        let hundredths = Int((timeInterval.truncatingRemainder(dividingBy: 1) * 100))
        
        if hours > 0 {
            return String(format: "%02d:%02d:%02d.%02d", hours, minutes, seconds, hundredths)
        } else {
            return String(format: "%02d:%02d.%02d", minutes, seconds, hundredths)
        }
    }
}

#Preview {
    ContentView()
}
