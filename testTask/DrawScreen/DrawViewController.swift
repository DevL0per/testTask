//
//  DrawViewController.swift
//  testTask
//
//  Created by Роман Важник on 23.04.2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit
import Macaw

class DrawViewController: UIViewController {
    
    var currentColor: Color = .blue
    var drawAreaModel: DrawAreaModel!
    
    private let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var drawArea: SVGView = {
        let svgView = SVGView()
        svgView.translatesAutoresizingMaskIntoConstraints = false
        svgView.fileName = drawAreaModel.imagePathWithoutNumbers
        svgView.contentMode = .scaleAspectFit
        return svgView
    }()
    
    private let colorCollectionViewPicker: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        //layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
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
    
    override func viewDidLoad() {
        drawArea.fileName = drawAreaModel.imagePathWithNumbers
        layoutDrawArea()
        setActionsToNodes()
        layoutBottomView()
    }
    
    private func setActionsToNodes() {
        drawAreaModel.nodes.keys.forEach { (pathTag) in
            for valueTag in 1...drawAreaModel.nodes[pathTag]! {
                let tag = "\(pathTag)_\(valueTag)"
                drawArea.node.nodeBy(tag: tag)?.onTouchPressed({ (touch) in
                    self.changeNodeColor(pathTag: pathTag, fullNodeTag: tag)
                })
            }
        }
    }
    
    private func changeNodeColor(pathTag: Int, fullNodeTag: String) {
        if drawAreaModel.correctColors[pathTag] == currentColor {
            let nodeShape = drawArea.node.nodeBy(tag: fullNodeTag) as! Shape
            nodeShape.fill = currentColor
        }
    }
    
    private func layoutBottomView() {
        view.addSubview(bottomView)
        bottomView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12).isActive = true
    }
    
    private func layoutDrawArea() {
        view.addSubview(drawArea)
        drawArea.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        drawArea.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        drawArea.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        drawArea.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
