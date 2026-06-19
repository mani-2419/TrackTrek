//
//  OTPViewController.swift
//  Tracking_Motion
//
//  Created by Manisha Kumari on 07/05/25.
//

import UIKit

class OTPViewController: UIViewController {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var requestLabel: UIButton!
    @IBOutlet var otpTextField: [UITextField]!
    var timer = Timer()
    var sec = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialView()
        startTimer()
    }
    func setInitialView() {
        backView.applyShadow()
        backView.setCornerRadius(25)
        GlobalHelper.setBackgroundImage(view)
        submitButton.setCornerRadius(10)
        submitButton.applyShadow()
        isEnabledRequestLabel(isEnabled: false)
    }
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(OTPViewController.updateTimer), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        sec -= 1
        timerLabel.text = "00:\(sec)"
        
        if (sec == 0) {
            timer.invalidate()
            isEnabledRequestLabel(isEnabled: true)
        }
    }
    @IBAction func clickOnSubmitButton(_ sender: Any) {
        AppRouter.switchToHomeVC()
    }
    
    func isEnabledRequestLabel(isEnabled: Bool) {
        if isEnabled {
            requestLabel.tintColor = .red
            requestLabel.layer.opacity = 1.0
            requestLabel.isUserInteractionEnabled = isEnabled
            timerLabel.layer.opacity = 0.3
            timerLabel.isUserInteractionEnabled = !isEnabled
        } else {
            requestLabel.layer.opacity = 0.3
            requestLabel.isUserInteractionEnabled = isEnabled
        }
    }
}
