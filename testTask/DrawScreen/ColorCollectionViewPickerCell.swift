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
    static let colorImageSize: CGFloat = 25
}

class ColorCollectionViewPickerCell: UICollectionViewCell {
    
    private let colorImage: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = Constants.colorImageSize/2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 10)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        layoutColorImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImageColor(color: Color, number: Int) {
        numberLabel.text = String(number)
        colorImage.backgroundColor = UIColor(cgColor: color.toCG())
    }
    
    private func layoutColorImage() {
        addSubview(colorImage)
        colorImage.heightAnchor.constraint(equalToConstant: Constants.colorImageSize).isActive = true
        colorImage.widthAnchor.constraint(equalToConstant: Constants.colorImageSize).isActive = true
        colorImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        colorImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        colorImage.addSubview(numberLabel)
        numberLabel.centerYAnchor.constraint(equalTo: colorImage.centerYAnchor).isActive = true
        numberLabel.centerXAnchor.constraint(equalTo: colorImage.centerXAnchor).isActive = true
    }
    
}
