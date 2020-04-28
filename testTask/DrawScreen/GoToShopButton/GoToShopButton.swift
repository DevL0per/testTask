//
//  GoToShopButton.swift
//  testTask
//
//  Created by Роман Важник on 28.04.2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

class GoToShopButton: UIButton {
    
    let shapeLayer = CAShapeLayer()
    var isStrokeEnd = false
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted && !isStrokeEnd {
                self.startStrokeAnimation(fromValue: 0, value: 1, delay: 0)
                self.isStrokeEnd = true
            } else if !isHighlighted && isStrokeEnd {
                self.startStrokeAnimation(fromValue: 1, value: 0, delay: 0.5)
                self.isStrokeEnd = false
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createLayer()
    }
    
    func startStrokeAnimation(fromValue: Int, value: Int, delay: Double) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = fromValue
        animation.beginTime = CACurrentMediaTime() + delay
        animation.toValue = value
        animation.duration = 0.5
        animation.fillMode = .both
        animation.isRemovedOnCompletion = false
        self.shapeLayer.add(animation, forKey: "line")
        isStrokeEnd = true
    }
    
    func createLayer() {
        layer.masksToBounds = false
        layer.addSublayer(shapeLayer)
        
        shapeLayer.frame = bounds
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: -87, y: self.bounds.height-2))
        path.addCurve(to: CGPoint(x: -10, y: self.bounds.height-2),
                      controlPoint1: CGPoint(x: -89, y: self.bounds.height-2),
                      controlPoint2: CGPoint(x: self.bounds.width+30, y: self.bounds.height-2))
        
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = .none
        shapeLayer.strokeColor = #colorLiteral(red: 0.393315196, green: 0.2743449807, blue: 0.8032925725, alpha: 1).cgColor
        shapeLayer.lineWidth = 3
        shapeLayer.strokeEnd = 0
    }
}
