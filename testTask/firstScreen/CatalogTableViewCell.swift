//
//  catalogTableViewCell.swift
//  testTask
//
//  Created by Роман Важник on 22.04.2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

protocol CatalogTableViewCellDelegate {
    func showDrawScreen(at index: Int)
}

class CatalogTableViewCell: UITableViewCell {
    
    // CollectionView
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        let collectionView = UICollectionView(frame: self.frame,
                                              collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isUserInteractionEnabled = true
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.register(CatalogCollectionViewCell.self,
                                forCellWithReuseIdentifier: "CatalogCollectionViewCell")
        return collectionView
    }()
    
    var delegate: CatalogTableViewCellDelegate!
    
    // Title area
    private let titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let titleText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 9)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "013-more"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        titleLayout()
        collectionViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupElements(textForTitle: String, titleImage: UIImage) {
        titleText.text = textForTitle.uppercased()
        titleImageView.image = titleImage
    }
    
    private func titleLayout() {
        let titleView = UIView()
        addSubview(titleView)
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        titleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        titleView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        addSubview(titleView)
        
        titleView.addSubview(titleImageView)
        titleView.addSubview(titleText)
        titleView.addSubview(moreButton)
        
        titleImageView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor).isActive = true
        titleImageView.topAnchor.constraint(equalTo: titleView.topAnchor).isActive = true
        titleImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        titleImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        titleText.leadingAnchor.constraint(equalTo: titleImageView.trailingAnchor, constant: 9).isActive = true
        titleText.centerYAnchor.constraint(equalTo: titleImageView.centerYAnchor).isActive = true
        
        moreButton.trailingAnchor.constraint(equalTo: titleView.trailingAnchor).isActive = true
        moreButton.topAnchor.constraint(equalTo: titleView.topAnchor).isActive = true
    }
    
    private func collectionViewLayout() {
        addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: titleImageView.bottomAnchor, constant: 15).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 128).isActive = true
    }
}

extension CatalogTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 128, height: 128)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.showDrawScreen(at: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatalogCollectionViewCell",
                                                                    for: indexPath) as! CatalogCollectionViewCell
        let path = data[indexPath.row].imagePathWithoutNumbers
        collectionViewCell.setupImage(withPath: path)
        return collectionViewCell
    }
}
