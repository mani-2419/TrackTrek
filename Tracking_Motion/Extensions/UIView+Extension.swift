//
//  UIView+Extension.swift
//  Tracking_Motion
//
//  Created by Manisha Kumari on 25/04/25.
//

import Foundation
import UIKit

extension UIView {
    //MARK: - Set shadow on UIView type with optional shadowOpacity
    func applyShadow(shadowOpacity: Float? = 0.30) {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOpacity = shadowOpacity ?? 0.30
            self.layer.shadowOffset = CGSize(width: 0, height: 4)
            self.layer.shadowRadius = 8
            self.layer.masksToBounds = false
        }
    //MARK: - Set corner radius on UIView type with optional radius
    func setCornerRadius(_ radius: Double? = 30) {
        self.layer.cornerRadius = radius ?? 30
    }
}
