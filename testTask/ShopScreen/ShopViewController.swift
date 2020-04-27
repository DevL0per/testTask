//
//  ShopViewController.swift
//  testTask
//
//  Created by Роман Важник on 26.04.2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 252, left: 15, bottom: 10, right: 15)
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.layer.masksToBounds = true
        collectionView.register(ShopCollectionViewCell.self,
                                forCellWithReuseIdentifier: "ShopCell")
        collectionView.layer.cornerRadius = 10
        return collectionView
    }()
    
    private lazy var shadowView: ViewWithShadow = {
        let view = ViewWithShadow()
        view.frame = self.collectionView.bounds
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let backButton: DrawScreenButton = {
        let button = DrawScreenButton()
        button.layer.cornerRadius = 25
        button.setImage(UIImage(named: "092-cancel-2"), for: .normal)
        button.addTarget(self, action: #selector(backButtonWasPressed), for: .touchUpInside)
        return button
    }()
    
    private let contentViewRightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 14)
        label.text = "20k"
        label.textColor = #colorLiteral(red: 0.9098039216, green: 0.262745098, blue: 0.5764705882, alpha: 1)
        return label
    }()
    
    private let moreColorsLabel: UILabel = {
        let label = UILabel()
        label.text = "MORE COLORS"
        label.textAlignment = .center
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layoutCollectionView()
        layoutTopViewInformation()
    }
    
    @objc private func backButtonWasPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func layoutCollectionView() {
        
        view.addSubview(shadowView)
        shadowView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        shadowView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        shadowView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        shadowView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
        
        shadowView.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: shadowView.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor).isActive = true
    }
    
    private func layoutTopViewInformation() {
        
        collectionView.addSubview(backButton)
        backButton.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 17).isActive = true
        backButton.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        collectionView.addSubview(moreColorsLabel)
        moreColorsLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 27).isActive = true
        moreColorsLabel.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        
        let contentView = ViewWithShadow()
        contentView.layer.cornerRadius = 15
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.addSubview(contentView)
        contentView.topAnchor.constraint(equalTo: moreColorsLabel.bottomAnchor, constant: 30).isActive = true
        contentView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalToConstant: 113).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let colorImageView = UIImageView(image: UIImage(named: "paint24"))
        colorImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(colorImageView)
        colorImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 13).isActive = true
        colorImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        colorImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        colorImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        contentView.addSubview(contentViewRightLabel)
        contentViewRightLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -19).isActive = true
        contentViewRightLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
}

extension ShopViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 5
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width-30, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCell", for: indexPath) as! ShopCollectionViewCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 252, left: 0, bottom: 0, right: 0)
        } else {
            return UIEdgeInsets(top: 32, left: 0, bottom: 20, right: 0)
        }
    }
    
}

//class ShopCollectionView: UICollectionView {
//
//    private var shadowLayer: CAShapeLayer!
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        if shadowLayer == nil {
//            shadowLayer = CAShapeLayer()
//            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 12).cgPath
//            shadowLayer.fillColor = UIColor.white.cgColor
//
//            shadowLayer.shadowColor = UIColor.darkGray.cgColor
//            shadowLayer.shadowPath = shadowLayer.path
//            shadowLayer.shadowOffset = CGSize(width: 0, height: 5.0)
//            shadowLayer.shadowOpacity = 0.2
//            shadowLayer.shadowRadius = 10
//
//            layer.masksToBounds = false
//            layer.insertSublayer(shadowLayer, below: nil)
//        }
//    }
//}
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        layer.shadowColor = UIColor.gray.cgColor
//        layer.shadowOffset = CGSize(width: 0, height: 5.0)
//        layer.shadowRadius = 10
//        layer.shadowOpacity = 0.2
//        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
//    }
//
