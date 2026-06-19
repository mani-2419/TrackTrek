//
//  AppRouter.swift
//  Tracking_Motion
//
//  Created by Manisha Kumari on 05/05/25.
//

import Foundation
import UIKit
import GoogleSignIn

class AppRouter {
    // MARK: - Switch to Home screen
   static func switchToHomeVC() {
       let storyboard = UIStoryboard(name: CellIdentifier.main, bundle: nil)
       let homeVC = storyboard.instantiateViewController(withIdentifier: CellIdentifier.navVC)
       rootScreen(homeVC)
    }
    static func signOut() {
        GIDSignIn.sharedInstance.signOut()
        let loginVC = LoginViewController(nibName: CellIdentifier.loginVC, bundle: nil)
        let navController = UINavigationController(rootViewController: loginVC)
        rootScreen(navController)
    }
    
   private static func rootScreen(_ rootVC: UIViewController) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window {
            window.rootViewController = rootVC
            window.makeKeyAndVisible()
        }
    }
}
