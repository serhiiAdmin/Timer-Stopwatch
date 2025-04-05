//
//  NumberPadView.swift
//  TimerApp
//
//

import SwiftUI

struct NumberPadView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var value: Int
    let maxValue: Int
    let component: String
    @State private var tempValue: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Set \(component)")
                .font(.headline)
            
            Text(tempValue.isEmpty ? "00" : tempValue)
                .font(.system(size: 42, weight: .medium, design: .rounded))
                .monospacedDigit()
                .frame(height: 50)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 12) {
                ForEach(1...9, id: \.self) { number in
                    NumberButton(number: "\(number)") {
                        appendDigit(number)
                    }
                }
                
                NumberButton(number: "←") {
                    removeLastDigit()
                }
                
                NumberButton(number: "0") {
                    appendDigit(0)
                }
                
                NumberButton(number: "Set") {
                    setValue()
                }
            }
            .padding()
        }
        .padding()
        .onAppear {
            tempValue = "\(value)"
        }
    }
    
    private func appendDigit(_ digit: Int) {
        let newValue = (tempValue + "\(digit)")
        if let intValue = Int(newValue), intValue <= maxValue {
            tempValue = "\(intValue)"
        }
    }
    
    private func removeLastDigit() {
        if !tempValue.isEmpty {
            tempValue.removeLast()
        }
    }
    
    private func setValue() {
        if let intValue = Int(tempValue) {
            value = intValue
        }
        dismiss()
    }
}
