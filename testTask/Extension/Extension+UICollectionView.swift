//
//  Extension+UICollectionView.swift
//  testTask
//
//  Created by Роман Важник on 28.04.2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

extension UICollectionView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
