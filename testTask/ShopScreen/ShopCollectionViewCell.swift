//
//  ShopCollectionViewCell.swift
//  testTask
//
//  Created by Роман Важник on 26.04.2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

protocol ShopCollectionViewCellDelegate {
    func userPressedTheButton(numberOfPaintsToAdd: Int)
}

class ShopCollectionViewCell: UICollectionViewCell {
    
    private let numberOfPaints: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        label.textColor = #colorLiteral(red: 0.9098039216, green: 0.262745098, blue: 0.5764705882, alpha: 1)
        return label
    }()
    
    var delegate: ShopCollectionViewCellDelegate!
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "watch video"
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 10)
        return label
    }()

    private lazy var rightButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.4392156863, green: 0.1411764706, blue: 0.831372549, alpha: 1)
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(shopButtonWasPressed), for: .touchUpInside)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
        button.titleLabel?.font = UIFont(name: "Arial Rounded MT Pro Cyr", size: 12)
        button.layer.cornerRadius = 15
        return button
    }()
    
    private lazy var rightCostButton: ButtonWithShadow = {
        let button = ButtonWithShadow()
        button.layer.cornerRadius = 15
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(shopButtonWasPressed), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutElements()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupElementsInBonusSection(buttonImage: UIImage,
                                             buttonText: String,
                                             numberOfPaints: Int, subtitle: String) {
        
        rightButton.isHidden = false
        rightCostButton.isHidden = true
        subtitleLabel.textColor = .black
        rightButton.setImage(buttonImage, for: .normal)
        rightButton.setTitle(buttonText, for: .normal)
        self.numberOfPaints.text = String(numberOfPaints)
        self.subtitleLabel.text = subtitle
    }
    
    func setupElementsInDonateSection(cost: String,
                                              numberOfPaints: Int, subtitle: String) {
        rightButton.isHidden = true
        rightCostButton.isHidden = false
        subtitleLabel.textColor = #colorLiteral(red: 0.4674489498, green: 0.3423808217, blue: 0.8241974711, alpha: 1)
        rightCostButton.setTitle(cost, for: .normal)
        self.numberOfPaints.text = String(numberOfPaints)
        self.subtitleLabel.text = subtitle
    }
    
    @objc private func shopButtonWasPressed(button: UIButton) {
        if let numberOfPaints = Int(self.numberOfPaints.text!) {
            delegate.userPressedTheButton(numberOfPaintsToAdd: numberOfPaints)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    private func layoutElements() {
        let viewWithShadow = ViewWithShadow()
        viewWithShadow.isUserInteractionEnabled = true
        addSubview(viewWithShadow)
        viewWithShadow.layer.cornerRadius = 10
        viewWithShadow.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        viewWithShadow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        viewWithShadow.topAnchor.constraint(equalTo: topAnchor).isActive = true
        viewWithShadow.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        let drawImageView = UIImageView(image: UIImage(named: "paint24"))
        drawImageView.translatesAutoresizingMaskIntoConstraints = false
        viewWithShadow.addSubview(drawImageView)
        drawImageView.leadingAnchor.constraint(equalTo: viewWithShadow.leadingAnchor, constant: 15).isActive = true
        drawImageView.centerYAnchor.constraint(equalTo: viewWithShadow.centerYAnchor).isActive = true
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
        
        viewWithShadow.addSubview(textContentStackView)
        textContentStackView.centerYAnchor.constraint(equalTo: drawImageView.centerYAnchor).isActive = true
        textContentStackView.leadingAnchor.constraint(equalTo: drawImageView.trailingAnchor, constant: 14).isActive = true
        
        viewWithShadow.addSubview(rightButton)
        rightButton.centerYAnchor.constraint(equalTo: viewWithShadow.centerYAnchor).isActive = true
        rightButton.trailingAnchor.constraint(equalTo: viewWithShadow.trailingAnchor, constant: -15).isActive = true
        rightButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        rightButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
     
        viewWithShadow.addSubview(rightCostButton)
        rightCostButton.centerYAnchor.constraint(equalTo: viewWithShadow.centerYAnchor).isActive = true
        rightCostButton.trailingAnchor.constraint(equalTo: viewWithShadow.trailingAnchor, constant: -15).isActive = true
        rightCostButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        rightCostButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
}

