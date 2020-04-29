//
//  ShopViewController.swift
//  testTask
//
//  Created by Роман Важник on 26.04.2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController {
    
    let bonusSectionItems: [ShopModel] = [
        ShopModel(subtitle: "watch free video", buttonTitle: "Watch",
                  buttonImage: "Polygon", numbetOfPaints: 20),
        ShopModel(subtitle: "+ exclusive images", buttonTitle: "Join",
                  buttonImage: "facebook (1)", numbetOfPaints: 7000)
    ]
    let donateSectionItems: [ShopModel] = [
        ShopModel(subtitle: "", buttonTitle: "$1.19",
                  buttonImage: nil, numbetOfPaints: 1000),
        ShopModel(subtitle: "+ 2000 free bonus", buttonTitle: "$3.49",
                  buttonImage: nil, numbetOfPaints: 5000),
        ShopModel(subtitle: "+ 5000 free bonus", buttonTitle: "$5.99",
                  buttonImage: nil, numbetOfPaints: 10000),
        ShopModel(subtitle: "+ 5000 free bonus", buttonTitle: "$23.99",
                  buttonImage: nil, numbetOfPaints: 50000),
        ShopModel(subtitle: "+ 100 000 free bonus", buttonTitle: "$49.99",
                  buttonImage: nil, numbetOfPaints: 150000),
    ]
    
    var numberOfPaints: Int! {
        didSet {
            contentViewRightLabel.text = ConvertNumberManager.shared.convertNumberOfPaintsToString(number: numberOfPaints)
        }
    }
    var drawId: Int!
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 252, left: 15, bottom: 10, right: 15)
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isUserInteractionEnabled = true
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
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let magicStickCost: UILabel = {
        let label = UILabel()
        label.text = "5000"
        label.textAlignment = .center
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let magicLoupeCost: UILabel = {
        let label = UILabel()
        label.text = "3000"
        label.textAlignment = .center
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let backButton: ButtonWithShadow = {
        let button = ButtonWithShadow()
        button.layer.cornerRadius = 25
        let imageOne = SVGIconsManager.shared.returnImage(forResourceName: "092-cancel-2",
                                                          size: CGSize(width: 24, height: 24))
        let imageTwo = SVGIconsManager.shared.returnImage(forResourceName: "014-cancel",
                                                          size: CGSize(width: 24, height: 24))
        button.setImage(imageOne, for: .normal)
        button.setImage(imageTwo, for: .highlighted)
        button.addTarget(self, action: #selector(backButtonWasPressed), for: .touchUpInside)
        return button
    }()
    
    private let contentViewRightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 14)
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
    
    private let semathor = DispatchSemaphore(value: 1)

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
        
        let margins = view.layoutMarginsGuide
        view.addSubview(shadowView)
        shadowView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        shadowView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        shadowView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10).isActive = true
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
        
        let image = SVGIconsManager.shared.returnImage(forResourceName: "083-paint-1",
                                                       size: CGSize(width: 24, height: 24))
        let colorImageView = UIImageView(image: image)
        colorImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(colorImageView)
        colorImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 13).isActive = true
        colorImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        colorImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        colorImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        contentView.addSubview(contentViewRightLabel)
        contentViewRightLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -19).isActive = true
        contentViewRightLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = 30
        
        let magicStickViewStackView = UIStackView()
        magicStickViewStackView.axis = .horizontal
        magicStickViewStackView.distribution = .equalSpacing
        magicStickViewStackView.alignment = .center
        magicStickViewStackView.spacing = 5
        
        let groupOneimage = SVGIconsManager.shared.returnImage(forResourceName: "Group 21",
                                                       size: CGSize(width: 24, height: 16))
        magicStickViewStackView.addArrangedSubview(UIImageView(image: groupOneimage))
        magicStickViewStackView.addArrangedSubview(magicStickCost)
        
        let paintImage = SVGIconsManager.shared.returnImage(forResourceName: "083-paint-1",
                                                               size: CGSize(width: 8, height: 8))
        magicStickViewStackView.addArrangedSubview(UIImageView(image: paintImage))
        
        let magicLoupeViewStackView = UIStackView()
        magicLoupeViewStackView.axis = .horizontal
        magicLoupeViewStackView.distribution = .equalSpacing
        magicLoupeViewStackView.alignment = .center
        magicLoupeViewStackView.spacing = 5
        
        let groupTwoimage = SVGIconsManager.shared.returnImage(forResourceName: "Group 22",
                                                              size: CGSize(width: 24, height: 16))
        magicLoupeViewStackView.addArrangedSubview(UIImageView(image: groupTwoimage))
        magicLoupeViewStackView.addArrangedSubview(magicLoupeCost)
        magicLoupeViewStackView.addArrangedSubview(UIImageView(image: paintImage))
        
        stackView.addArrangedSubview(magicStickViewStackView)
        stackView.addArrangedSubview(magicLoupeViewStackView)
        collectionView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 15).isActive = true
        stackView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
    }
}

extension ShopViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return bonusSectionItems.count
        } else {
            return donateSectionItems.count
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
        if indexPath.section == 0 {
            let item = bonusSectionItems[indexPath.row]
            cell.setupElementsInBonusSection(buttonImage: item.buttonImage!,
                                             buttonText: item.buttonTitle,
                                             numberOfPaints: item.numbetOfPaints,
                                             subtitle: item.subtitle)
        } else {
            let item = donateSectionItems[indexPath.row]
            cell.setupElementsInDonateSection(cost: item.buttonTitle,
                                              numberOfPaints: item.numbetOfPaints,
                                              subtitle: item.subtitle)
        }
        cell.delegate = self
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

extension ShopViewController: ShopCollectionViewCellDelegate {
    
    func userPressedTheButton(numberOfPaintsToAdd: Int) {
        
        let workItem = DispatchWorkItem { [unowned self] in
            self.semathor.wait()
            UserDefaultsManager.shared.saveNumberOfPaints(drawId: self.drawId,
                                                          numberOfPaints: self.numberOfPaints+numberOfPaintsToAdd)
            self.semathor.signal()
        }
        workItem.notify(queue: .main) { [unowned self] in
            self.numberOfPaints+=numberOfPaintsToAdd
        }
        DispatchQueue.global(qos: .background).async(execute: workItem)
    }
}
