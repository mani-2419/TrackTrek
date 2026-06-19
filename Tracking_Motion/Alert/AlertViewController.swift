//
//  AlertViewController.swift
//  Tracking_Motion
//
//  Created by Manisha Kumari on 15/05/25.
//

import UIKit

class AlertViewController: UIViewController {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backView.layer.cornerRadius = 15.0
    }
    @IBAction func clickOnClose(_ sender: Any) {
        
    }
    
    @IBAction func clickOnConfirm(_ sender: Any) {
    }
}
