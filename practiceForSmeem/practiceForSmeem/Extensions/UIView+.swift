//
//  UIView+.swift
//  practiceForSmeem
//
//  Created by 임주민 on 2023/04/16.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}
