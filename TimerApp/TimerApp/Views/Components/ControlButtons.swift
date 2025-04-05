//
//  ControlButtons.swift
//  TimerApp
//
//

import SwiftUI

struct ControlButtons: View {
    let isRunning: Bool
    let startTimer: () -> Void
    let stopTimer: () -> Void
    let resetTimer: () -> Void
    
    var body: some View {
        HStack(spacing: 30) {
            Button(action: resetTimer) {
                Circle()
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 60, height: 60)
                    .overlay(
                        Image(systemName: "arrow.counterclockwise")
                            .font(.title3)
                            .foregroundColor(.white)
                    )
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
            }
            
            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    isRunning ? stopTimer() : startTimer()
                }
            }) {
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                isRunning ? Color(hex: "FF3B30") : Color(hex: "34C759"),
                                isRunning ? Color(hex: "FF3B30").opacity(0.8) : Color(hex: "34C759").opacity(0.8)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: 80, height: 80)
                    .overlay(
                        Image(systemName: isRunning ? "pause.fill" : "play.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                    )
                    .shadow(color: (isRunning ? Color(hex: "FF3B30") : Color(hex: "34C759")).opacity(0.3),
                            radius: 15, x: 0, y: 8)
            }
            .scaleEffect(isRunning ? 0.95 : 1.0)
        }
    }
}
