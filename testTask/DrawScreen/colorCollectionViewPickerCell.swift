//
//  colorCollectionViewPickerCell.swift
//  testTask
//
//  Created by Роман Важник on 25.04.2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit
import Macaw

fileprivate struct Constants {
    static let colorImageSize: CGFloat = 24
}

class colorCollectionViewPicker: UICollectionViewCell {
    
    private let colorImage: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = Constants.colorImageSize/2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutColorImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImageColor(color: Color) {
        colorImage.backgroundColor = UIColor(cgColor: color.toCG())
    }
    
    private func layoutColorImage() {
        addSubview(colorImage)
        colorImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        colorImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
}
