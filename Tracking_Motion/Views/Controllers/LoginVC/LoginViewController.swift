//
//  LoginViewController.swift
//  Tracking_Motion
//
//  Created by Manisha Kumari on 03/05/25.
//

import UIKit
import GoogleSignIn
import AuthenticationServices

class LoginViewController: UIViewController {
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var appleLoginButtonView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var phoneNumerTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialView()
        setAppleAccountView()
        GlobalHelper.setBackgroundImage(view)
    }
    func setInitialView() {
        self.upperView.applyShadow()
        self.upperView.setCornerRadius()
        self.bottomView.applyShadow(shadowOpacity: 0.35)
        self.bottomView.setCornerRadius()
        self.appleLoginButtonView.setCornerRadius(10)
        self.appleLoginButtonView.applyShadow(shadowOpacity: 0.35)
        self.loginButton.setCornerRadius(10)
        self.loginButton.applyShadow()
        errorLabel.isHidden = true
//        self.phoneNumerTextField.delegate = self
    }
    // MARK: - Set UI and action of Apple account
    func setAppleAccountView() {
        if appleLoginButtonView.subviews.isEmpty {
            let authorizationButton = ASAuthorizationAppleIDButton()
            authorizationButton.frame = appleLoginButtonView.bounds
            //                authorizationButton.addTarget(self, action: #selector(handleAppleIdRequest), for: .touchUpInside)
            //Add button on some view or stack
            appleLoginButtonView.addSubview(authorizationButton)
        }
    }
    func validation() {
        if (phoneNumerTextField.text?.isEmpty == true) {
            errorLabel.isHidden = false
            errorLabel.text = ErrorConstant.enterMobNo
        } else if (phoneNumerTextField.text?.count ?? 0 < 10) {
            errorLabel.isHidden = false
            errorLabel.text = ErrorConstant.shouldBeTen
        } else {
            errorLabel.isHidden = true
            let otpVC = OTPViewController(nibName: CellIdentifier.otpVC, bundle: nil)
            navigationController?.pushViewController(otpVC, animated: true)

        }
    }
    @IBAction func clickOnLoginButton(_ sender: Any) {
        validation()
    }
    @IBAction func clickOnGoogleSignIn(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else { return }
            
            // If sign in succeeded, display the app's main content View.
            guard let signInResult = signInResult else { return }
            AppRouter.switchToHomeVC()
            let user = signInResult.user
            let emailAddress = user.profile?.email
            let fullName = user.profile?.name
            let familyName = user.profile?.familyName
            let profilePicUrl = user.profile?.imageURL(withDimension: 320)
        }
    }
    
    @IBAction func clickOnFacebookSignIn(_ sender: Any) {
        let alertVC = AlertViewController(nibName: "AlertViewController", bundle: nil)
        alertVC.modalPresentationStyle = .overCurrentContext
        alertVC.modalTransitionStyle = .crossDissolve
        self.present(alertVC, animated: true, completion: nil)
        
    }
}
