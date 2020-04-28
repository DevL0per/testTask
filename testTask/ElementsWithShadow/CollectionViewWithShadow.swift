//
//  CollectionViewWithShadow.swift
//  testTask
//
//  Created by Роман Важник on 28.04.2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

class CollectionViewWithShadow: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5.0)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
    }
}
