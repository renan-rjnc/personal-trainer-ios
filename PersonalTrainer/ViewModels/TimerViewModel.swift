import Foundation
import SwiftUI
import AVFoundation

@Observable
final class TimerViewModel {
    enum TimerMode {
        case stopwatch
        case countdown
    }

    var mode: TimerMode = .stopwatch
    var elapsedTime: TimeInterval = 0
    var countdownDuration: TimeInterval = 60
    var isRunning: Bool = false

    private var timer: Timer?
    private var startTime: Date?
    private var accumulatedTime: TimeInterval = 0

    var displayTime: TimeInterval {
        switch mode {
        case .stopwatch:
            return elapsedTime
        case .countdown:
            return max(0, countdownDuration - elapsedTime)
        }
    }

    var formattedTime: String {
        let time = displayTime
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        let tenths = Int((time.truncatingRemainder(dividingBy: 1)) * 10)
        return String(format: "%02d:%02d.%d", minutes, seconds, tenths)
    }

    var isCountdownComplete: Bool {
        mode == .countdown && displayTime <= 0
    }

    // Preset countdown durations in seconds
    let countdownPresets: [TimeInterval] = [30, 60, 90, 120]

    func start() {
        guard !isRunning else { return }
        isRunning = true
        startTime = Date()

        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.updateTime()
        }
    }

    func pause() {
        guard isRunning else { return }
        isRunning = false
        accumulatedTime = elapsedTime
        timer?.invalidate()
        timer = nil
    }

    func reset() {
        pause()
        elapsedTime = 0
        accumulatedTime = 0
        startTime = nil
    }

    func setCountdown(seconds: TimeInterval) {
        reset()
        mode = .countdown
        countdownDuration = seconds
    }

    func switchToStopwatch() {
        reset()
        mode = .stopwatch
    }

    private func updateTime() {
        guard let startTime = startTime else { return }
        elapsedTime = accumulatedTime + Date().timeIntervalSince(startTime)

        if isCountdownComplete {
            pause()
            triggerNotification()
        }
    }

    private func triggerNotification() {
        // Haptic feedback
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)

        // Play system sound
        AudioServicesPlaySystemSound(1007)
    }
}
