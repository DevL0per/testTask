//
//  MenuBarCell.swift
//  testTask
//
//  Created by Роман Важник on 23.04.2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

class MenuBarCollectionViewCell: UICollectionViewCell {
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = self.bounds
        imageView.contentMode = .center
        return imageView
    }()
    private var imageName: String = ""
    
    override var isHighlighted: Bool {
        didSet {
            iconImageView.image = isHighlighted ? UIImage(named: imageName) : UIImage(named: imageName+"NotSelected")
        }
    }
    
    override var isSelected: Bool {
        didSet {
            iconImageView.image = isSelected ? UIImage(named: imageName) : UIImage(named: imageName+"NotSelected")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(iconImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupIconImageView(with imageName: String) {
        iconImageView.image = UIImage(named: imageName+"NotSelected")
        self.imageName = imageName
    }
}
