//
//  ContentView.swift
//  App Lock
//
//  Created by Aaron Recalde on 11/2/26.
//

import SwiftUI
internal import Combine

struct ContentView: View {
    // Seconds left in the break. 15 minutes = 900 seconds.
    @State private var secondsLeft = 15 * 60
    // True while a break is counting down.
    @State private var isRunning = false

    // Fires once per second.
    private let ticker = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    // Turns 900 into "15:00".
    private var timeString: String {
        String(format: "%02d:%02d", secondsLeft / 60, secondsLeft % 60)
    }

    var body: some View {
        VStack(spacing: 24) {
            Text(timeString)
                .font(.system(size: 64, weight: .bold, design: .monospaced))

            Button(isRunning ? "Break running..." : "Start break") {
                secondsLeft = 15 * 60
                isRunning = true
            }
            .buttonStyle(.borderedProminent)
            .disabled(isRunning)

            if secondsLeft == 0 {
                Text("Break over. Back to work.")
                    .font(.headline)
            }
        }
        .padding()
        .onReceive(ticker) { _ in
            guard isRunning else { return }
            secondsLeft -= 1
            if secondsLeft <= 0 {
                secondsLeft = 0
                isRunning = false

            }
        }
    }
}

#Preview {
    ContentView()
}
