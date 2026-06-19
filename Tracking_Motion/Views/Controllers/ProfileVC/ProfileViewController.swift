//
//  ProfileViewController.swift
//  Tracking_Motion
//
//  Created by Manisha Kumari on 24/04/25.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        GlobalHelper.setBackgroundImage(view)
    }

    @IBAction func clickOnSignOut(_ sender: Any) {
        AppRouter.signOut()
    }
}
