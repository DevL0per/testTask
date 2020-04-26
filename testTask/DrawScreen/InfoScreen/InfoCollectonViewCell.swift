//
//  InfoCollectonViewCell.swift
//  testTask
//
//  Created by Роман Важник on 26.04.2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit


class InfoCollectonViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bottomStackView = UIStackView()
    
    private let middleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "Arial Rounded MT Pro Cyr", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bottomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "paint24")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupElements(item: InfoScreenModel) {
        imageView.image = item.image
        titleLabel.text = item.title
        middleLabel.text = item.subtitle
        if item.drawCost > 0 {
            bottomLabel.text = String(item.drawCost)
        } else {
            bottomStackView.isHidden = true
        }
    }
    
    private func layoutElements() {
        
        //imageViewLayout
        imageView.widthAnchor.constraint(equalToConstant: 96).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 96).isActive = true
        
        //bottomImageViewLayout
        bottomImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        bottomImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        let textContentStackView = UIStackView()
        textContentStackView.axis = .vertical
        textContentStackView.distribution = .equalSpacing
        textContentStackView.alignment = .center
        textContentStackView.spacing = 15
        
        bottomStackView.axis = .horizontal
        bottomStackView.distribution = .equalSpacing
        bottomStackView.spacing = 7
        bottomStackView.addArrangedSubview(bottomLabel)
        bottomStackView.addArrangedSubview(bottomImageView)
        
        textContentStackView.addArrangedSubview(titleLabel)
        textContentStackView.addArrangedSubview(middleLabel)
        textContentStackView.addArrangedSubview(bottomStackView)
        
        let fullContentStackView = UIStackView()
        fullContentStackView.axis = .vertical
        fullContentStackView.distribution = .equalSpacing
        fullContentStackView.alignment = .center
        fullContentStackView.spacing = 53
        
        fullContentStackView.addArrangedSubview(imageView)
        fullContentStackView.addArrangedSubview(textContentStackView)
        fullContentStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(fullContentStackView)
        fullContentStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        fullContentStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
