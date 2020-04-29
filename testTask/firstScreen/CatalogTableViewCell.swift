//
//  catalogTableViewCell.swift
//  testTask
//
//  Created by Роман Важник on 22.04.2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

fileprivate struct Constants {
    static let collectionViewCellSize: CGFloat = 128
    static let collectionViewSpacing: CGFloat = 15
    static let topViewHeight: CGFloat = 72
    static let titleImageViewSize: CGFloat = 16
}

protocol CatalogTableViewCellDelegate {
    func showDrawScreen(at index: Int, section: Int)
}

class CatalogTableViewCell: UITableViewCell {
    
    var draws: [DrawAreaModel]!
    var numberOfSection: Int!
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        let collectionView = UICollectionView(frame: self.frame,
                                              collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isUserInteractionEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
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
        let image = SVGIconsManager.shared.returnImage(forResourceName: "013-more", size: CGSize(width: 16, height: 14))
        button.setImage(image, for: .normal)
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
    
    // MARK: - Elemens Layouts
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
        titleImageView.widthAnchor.constraint(equalToConstant: Constants.titleImageViewSize).isActive = true
        titleImageView.heightAnchor.constraint(equalToConstant: Constants.titleImageViewSize).isActive = true
        
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
        collectionView.heightAnchor.constraint(equalToConstant: Constants.collectionViewCellSize).isActive = true
    }
}


// MARK: - UITableView(Delegate, DataSource)
extension CatalogTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.collectionViewCellSize,
                      height: Constants.collectionViewCellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.collectionViewSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return draws.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.showDrawScreen(at: indexPath.row, section: numberOfSection)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatalogCollectionViewCell",
                                                                    for: indexPath) as! CatalogCollectionViewCell
        let draw = draws[indexPath.row]
        let path = draw.imagePathWithoutNumbers
        collectionViewCell.setupImage(withPath: path)
        return collectionViewCell
    }
}
