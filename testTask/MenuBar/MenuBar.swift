//
//  Menu.swift
//  testTask
//
//  Created by Роман Важник on 23.04.2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

private struct Constants {
    static let menuCollectionViewHeight: CGFloat = 50
    static let collectionViewinsets: CGFloat = 13
    static let collectionViewSizeCellSize: CGFloat = 28
    static let numberOfItemsInSection = 4
}

protocol MenuBarDelegate {
    func menuBarWasSelected(at index: Int)
}

class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {
    
    private lazy var menuCollectionView: CollectionViewWithShadow = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: Constants.collectionViewinsets,
                                           left: Constants.collectionViewinsets,
                                           bottom: Constants.collectionViewinsets,
                                           right: Constants.collectionViewinsets)
        let collectionView = CollectionViewWithShadow(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.masksToBounds = true
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .white
        collectionView.layer.cornerRadius = Constants.menuCollectionViewHeight/2
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MenuBarCollectionViewCell.self, forCellWithReuseIdentifier: "menuCell")
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        menuCollectionViewLayout()
        //wait until tableViewСells will be ready
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) { [weak self] in
            self?.menuCollectionView.selectItem(at: IndexPath(item: 0, section: 0),
                                                  animated: false, scrollPosition: .left)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Elemens Layouts
    private func menuCollectionViewLayout() {
        addSubview(menuCollectionView)
        menuCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        menuCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
        menuCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        menuCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
    }
    
    var delegate: MenuBarDelegate!
    
    //MARK: - CollectionViewDataSource, CollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.collectionViewSizeCellSize,
                      height: Constants.collectionViewSizeCellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.menuBarWasSelected(at: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return frame.width/7
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell",
                                                      for: indexPath) as! MenuBarCollectionViewCell
        let imageName = "menuItem" + String(indexPath.row)
        cell.setupIconImageView(with: imageName)
        return cell
    }
}
