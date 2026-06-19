//
//  ActivityTimer.swift
//  Tracking_Motion
//
//  Created by Manisha Kumari on 25/04/25.
//

import Foundation
import UIKit

class ActivityTimer {
    private var timer: DispatchSourceTimer?
    private var startTime: Date?
    private var elapsedTime: TimeInterval = 0
    weak var timerLabel: UILabel?
    
    init(timerLabel: UILabel? = nil) {
        self.timerLabel = timerLabel
    }
    //MARK: - Start the timer
    func start() {
        startTime = Date()
        timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        timer?.schedule(deadline: .now(), repeating: 1.0)
        timer?.setEventHandler { [weak self] in
            guard let self = self, let start = self.startTime else { return }
            self.elapsedTime = Date().timeIntervalSince(start)
            DispatchQueue.main.async {
                self.timerLabel?.attributedText = GlobalHelper.showText(title: StringConstant.timing, value: self.formatTime(self.elapsedTime))
            }
        }
        timer?.resume()
    }
    
    //MARK: - Stop the timer
    func stop() {
        timer?.cancel()
        timer = nil
        ///Important: freeze the timer
        startTime = nil
        self.timerLabel?.attributedText = GlobalHelper.showText(title: StringConstant.timing, value: self.formatTime(self.elapsedTime))
    }
    
    
    //MARK: - Reset the timer
    func reset() {
        stop()
        elapsedTime = 0
        self.timerLabel?.attributedText = GlobalHelper.showText(title: StringConstant.timing, value: StringConstant.zeroTime)
    }
    
    //MARK: - Format time (hh:mm:ss)
    private func formatTime(_ interval: TimeInterval) -> String {
        let seconds = Int(interval) % 60
        let minutes = (Int(interval) / 60) % 60
        let hours = Int(interval) / 3600
        return String(format: StringConstant.timeFormat, hours, minutes, seconds)
    }
}
