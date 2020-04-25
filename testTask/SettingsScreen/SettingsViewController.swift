//
//  SettingsViewController.swift
//  testTask
//
//  Created by Роман Важник on 23.04.2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    fileprivate let items: [SettingsItem] = [
        SettingsItem(text: "Restore\n Purchases", image: UIImage(named: "011-restore")!),
        SettingsItem(text: "Tell a friend", image: UIImage(named: "010-tell-a-friend")!),
        SettingsItem(text: "Rate &\n Review", image: UIImage(named: "009-rate-review")!),
        SettingsItem(text: "Privacy\n Policy", image: UIImage(named: "097-padlock")!),
        SettingsItem(text: "Terms\n of Use", image: UIImage(named: "007-law")!),
        SettingsItem(text: "Support &\n Feedback", image: UIImage(named: "006-support")!)
    ]

    private let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 70, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.register(SettingsCollectionViewCell.self, forCellWithReuseIdentifier: "settingsCell")
        return collectionView
    }()
    
    private var segmentedControll: UISegmentedControl = {
        let segmentedControll = UISegmentedControl(items: ["INFO", "SUGGESTIONS"])
        segmentedControll.translatesAutoresizingMaskIntoConstraints = false
        segmentedControll.removeBorders()
        segmentedControll.backgroundColor = .clear
        segmentedControll.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.7046068311, green: 0.686897099, blue: 0.7336240411, alpha: 1),
                                                  NSAttributedString.Key.font : UIFont(name: "Arial Rounded MT Bold",
                                                                                       size: 14)!],
                                                 for: .normal)
        segmentedControll.selectedSegmentIndex = 0
        segmentedControll.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black],
        for: .selected)
        segmentedControll.selectedSegmentTintColor = .clear
        return segmentedControll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutTopView()
        layoutCollectionView()
    }
    
    private func layoutTopView() {
        view.addSubview(topView)
        topView.addSubview(segmentedControll)
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 72).isActive = true
        
        segmentedControll.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        segmentedControll.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
    }
    
    private func layoutCollectionView() {
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    fileprivate func setShodowToCell(cell: SettingsCollectionViewCell) {
        cell.contentView.layer.cornerRadius = 8
        cell.contentView.layer.borderWidth = 1.0

        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true

        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 10
        cell.layer.shadowOpacity = 0.2
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
    }

}

extension SettingsViewController: UICollectionViewDelegateFlowLayout,
UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width/2 - 40, height: 122)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "settingsCell", for: indexPath) as! SettingsCollectionViewCell
        setShodowToCell(cell: cell)
        let item = items[indexPath.row]
        cell.setupElements(text: item.text, image: item.image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 16
       }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
