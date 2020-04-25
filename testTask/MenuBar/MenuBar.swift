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
}

protocol MenuBarDelegate {
    func menuBarWasSelected(at index: Int)
}

class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {
    
    lazy var menuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 13, left: 13, bottom: 13, right: 13)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.masksToBounds = true
        collectionView.backgroundColor = .white
        collectionView.layer.cornerRadius = Constants.menuCollectionViewHeight/2
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MenuBarCollectionViewCell.self, forCellWithReuseIdentifier: "menuCell")
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9346082807, green: 0.9346082807, blue: 0.9346082807, alpha: 1)
        menuCollectionViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func menuCollectionViewLayout() {
        addSubview(menuCollectionView)
        menuCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        menuCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
        menuCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        menuCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
    }
    
    var delegate: MenuBarDelegate!
    
    //MARK: - collectionViewDataSource, collectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 28, height: 28)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.menuBarWasSelected(at: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return frame.width/7
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell",
                                                      for: indexPath) as! MenuBarCollectionViewCell
        let imageName = "menuItem" + String(indexPath.row)
        cell.setupIconImageView(with: UIImage(named: imageName)!)
        return cell
    }
}
