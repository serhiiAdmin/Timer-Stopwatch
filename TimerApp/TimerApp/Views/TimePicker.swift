//
//  TimePicker.swift
//  TimerApp
//
//

import SwiftUI

struct TimePicker: View {
    @Binding var selectedTime: TimeInterval
    @State private var hours: Int = 0
    @State private var minutes: Int = 0
    @State private var seconds: Int = 0
    @State private var showingNumberPad = false
    @State private var editingComponent: TimeComponent?
    
    enum TimeComponent: String {
        case hours, minutes, seconds
    }
    
    var body: some View {
        VStack(spacing: 15) {
            // Time display with tappable components
            HStack(spacing: 4) {
                TimeComponentView(
                    value: hours,
                    label: "h",
                    isSelected: editingComponent == .hours
                ) {
                    editingComponent = .hours
                    showingNumberPad = true
                }
                
                Text(":")
                    .font(.title)
                    .foregroundColor(.gray)
                
                TimeComponentView(
                    value: minutes,
                    label: "m",
                    isSelected: editingComponent == .minutes
                ) {
                    editingComponent = .minutes
                    showingNumberPad = true
                }
                
                Text(":")
                    .font(.title)
                    .foregroundColor(.gray)
                
                TimeComponentView(
                    value: seconds,
                    label: "s",
                    isSelected: editingComponent == .seconds
                ) {
                    editingComponent = .seconds
                    showingNumberPad = true
                }
            }
            .padding(.vertical)
            
            // Quick preset buttons
            HStack(spacing: 12) {
                ForEach([1, 3, 5, 10], id: \.self) { minutes in
                    Button(action: {
                        setTime(minutes: minutes)
                    }) {
                        Text("\(minutes)m")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(
                                Capsule()
                                    .fill(Color.gray.opacity(0.2))
                            )
                    }
                }
            }
        }
        .sheet(isPresented: $showingNumberPad) {
            NumberPadView(
                value: binding(for: editingComponent),
                maxValue: maxValue(for: editingComponent),
                component: editingComponent?.rawValue ?? ""
            )
            .presentationDetents([.height(380)])
        }
        .onChange(of: hours) { _ in updateSelectedTime() }
        .onChange(of: minutes) { _ in updateSelectedTime() }
        .onChange(of: seconds) { _ in updateSelectedTime() }
        .onAppear {
            hours = Int(selectedTime) / 3600
            minutes = Int(selectedTime) / 60 % 60
            seconds = Int(selectedTime) % 60
        }
    }
    
    private func setTime(minutes: Int) {
        self.minutes = minutes
        self.hours = 0
        self.seconds = 0
        updateSelectedTime()
    }
    
    private func binding(for component: TimeComponent?) -> Binding<Int> {
        switch component {
        case .hours:
            return $hours
        case .minutes:
            return $minutes
        case .seconds:
            return $seconds
        case .none:
            return .constant(0)
        }
    }
    
    private func maxValue(for component: TimeComponent?) -> Int {
        switch component {
        case .hours:
            return 23
        case .minutes, .seconds:
            return 59
        case .none:
            return 0
        }
    }
    
    private func updateSelectedTime() {
        selectedTime = TimeInterval(hours * 3600 + minutes * 60 + seconds)
    }
}
