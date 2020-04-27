//
//  ShopCollectionViewCell.swift
//  testTask
//
//  Created by Роман Важник on 26.04.2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

class ShopCollectionViewCell: UICollectionViewCell {
    
    private let numberOfPaints: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "20"
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        label.textColor = #colorLiteral(red: 0.9098039216, green: 0.262745098, blue: 0.5764705882, alpha: 1)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "watch video"
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 10)
        return label
    }()

    private let rightButton: LeftAlignedIconButton = {
        let button = LeftAlignedIconButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.4392156863, green: 0.1411764706, blue: 0.831372549, alpha: 1)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutElements() {
        let contentView = ViewWithShadow()
        addSubview(contentView)
        contentView.layer.cornerRadius = 10
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        let drawImageView = UIImageView(image: UIImage(named: "paint24"))
        drawImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(drawImageView)
        drawImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        drawImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        drawImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        drawImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        let textContentStackView = UIStackView()
        textContentStackView.axis = .vertical
        textContentStackView.distribution = .equalSpacing
        textContentStackView.alignment = .leading
        textContentStackView.spacing = 0
        textContentStackView.translatesAutoresizingMaskIntoConstraints = false
        textContentStackView.addArrangedSubview(numberOfPaints)
        textContentStackView.addArrangedSubview(subtitleLabel)
        
        contentView.addSubview(textContentStackView)
        textContentStackView.centerYAnchor.constraint(equalTo: drawImageView.centerYAnchor).isActive = true
        textContentStackView.leadingAnchor.constraint(equalTo: drawImageView.trailingAnchor, constant: 14).isActive = true
        
        contentView.addSubview(rightButton)
        rightButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        rightButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        rightButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
}

class LeftAlignedIconButton: UIButton {
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleRect = super.titleRect(forContentRect: contentRect)
        let imageSize = currentImage?.size ?? .zero
        let availableWidth = contentRect.width - imageEdgeInsets.right - imageSize.width - titleRect.width
        return titleRect.offsetBy(dx: round(availableWidth / 2), dy: 0)
    }
}
