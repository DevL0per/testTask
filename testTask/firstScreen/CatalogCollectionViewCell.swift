//
//  CatalogCollectionViewCell.swift
//  testTask
//
//  Created by Роман Важник on 25.04.2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit
import Macaw

class CatalogCollectionViewCell: UICollectionViewCell {
     
    private lazy var image: SVGView = {
        let image = SVGView()
        image.frame = self.bounds
        return image
    }()
    
    private let shadowView = ViewWithShadow()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(shadowView)
        shadowView.frame = self.bounds
        addSubview(image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupImage(withPath: String) {
        image.fileName = withPath
    }
}
