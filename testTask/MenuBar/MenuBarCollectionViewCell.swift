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
    static let size = CGSize(width: 24, height: 24)
    private var imageName: String = ""
    
    override var isHighlighted: Bool {
        didSet {
            let imagTransform: CGFloat = isHighlighted ? 1.1 : 1
            iconImageView.transform = CGAffineTransform(scaleX: imagTransform,
                                                        y: imagTransform)
            
        }
    }
    
    override var isSelected: Bool {
        didSet {
            let iconName = isSelected ? imageName+"Selected" : imageName
            SVGIconsManager.shared.setImage(forResourceName: iconName,
                                            size: MenuBarCollectionViewCell.size, inObject: iconImageView)
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
        SVGIconsManager.shared.setImage(forResourceName: imageName,
                                        size: MenuBarCollectionViewCell.size,
                                        inObject: iconImageView)
        self.imageName = imageName
    }
}
