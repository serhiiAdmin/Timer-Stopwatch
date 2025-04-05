//
//  MainContentView.swift
//  TimerApp
//
//

import SwiftUI

struct MainContentView: View {
    @Binding var timeElapsed: TimeInterval
    @Binding var selectedTime: TimeInterval
    @Binding var isRunning: Bool
    @Binding var mode: Mode
    let startTimer: () -> Void
    let stopTimer: () -> Void
    let resetTimer: () -> Void
    
    var body: some View {
        VStack(spacing: 40) {
            ModeSelector(mode: $mode)
                .padding(.top, 20)
            
            if mode == .timer && !isRunning {
                TimePicker(selectedTime: $selectedTime)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
            
            Spacer()
            
            TimeDisplayView(timeElapsed: timeElapsed, mode: mode)
          
            Spacer()
            
            ControlButtons(
                isRunning: isRunning,
                startTimer: startTimer,
                stopTimer: stopTimer,
                resetTimer: resetTimer
            )
            .padding(.bottom, 30)
        }
        .padding()
        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: mode)
    }
}
