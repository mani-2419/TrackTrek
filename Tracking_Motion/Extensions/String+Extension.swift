//
//  String+Extension.swift
//  Tracking_Motion
//
//  Created by Manisha Kumari on 25/04/25.
//

import Foundation
import UIKit

extension String {
    func applyCustomStyle(color: UIColor = UIColor.black, fontSize: CGFloat = 15, weight: UIFont.Weight = .regular, fontName: String? = nil) -> NSAttributedString {
        let font: UIFont
        
        if let name = fontName, let customFont = UIFont(name: name, size: fontSize) {
            font = customFont
        } else {
            font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        }
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: font
        ]
        return NSAttributedString(string: self, attributes: attributes)
    }
}
