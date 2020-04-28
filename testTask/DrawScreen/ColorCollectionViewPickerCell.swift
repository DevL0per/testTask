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
    static let colorImageSize: CGFloat = 20
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
    let shapeLayer = CAShapeLayer()
    var numberOfNodes: Int!
    var numberOfColorizedNodes: Int = 0

    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                colorImage.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                setShapePath(withConstant: 0)
            } else {
                colorImage.transform = CGAffineTransform(scaleX: 1, y: 1)
                setShapePath(withConstant: 2)
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                colorImage.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                setShapePath(withConstant: 0)
            } else {
                colorImage.transform = CGAffineTransform(scaleX: 1, y: 1)
                setShapePath(withConstant: 2)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        layoutColorImage()
        setShapeLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImageColor(color: Color, number: Int, numberOfNodes: Int) {
        numberLabel.text = String(number)
        colorImage.backgroundColor = UIColor(cgColor: color.toCG())
        self.numberOfNodes = numberOfNodes
    }
    
    func nodeWasColorized() {
        numberOfColorizedNodes+=1
        shapeLayer.strokeEnd = CGFloat(numberOfColorizedNodes)/CGFloat(numberOfNodes)
    }
    
    private func setShapeLayer() {
        layer.addSublayer(shapeLayer)
        
        shapeLayer.frame = bounds
        setShapePath(withConstant: 2)
        shapeLayer.fillColor = .none
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 3
        shapeLayer.strokeEnd = 0
    }
    
    private func setShapePath(withConstant constant: CGFloat) {
        shapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: bounds.origin.x+12.5, y: bounds.origin.y+12.5),
                                radius: bounds.height/2-constant,
                                startAngle: 3*CGFloat.pi/2,
                                endAngle: (CGFloat.pi*3.60),
                                clockwise: true).cgPath
    }
 
    // MARK: - elements layouts
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
