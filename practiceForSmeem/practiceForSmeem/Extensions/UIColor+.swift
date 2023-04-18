//
//  UIColor+.swift
//  practiceForSmeem
//
//  Created by 임주민 on 2023/04/18.
//

import UIKit
extension UIColor {
    convenience init(rgb: Int) {
        self.init(
            red: CGFloat((rgb >> 16) & 0xFF),
            green: CGFloat((rgb >> 8) & 0xFF),
            blue: CGFloat(rgb & 0xFF),
            alpha: 1.0
        )
    }
}
