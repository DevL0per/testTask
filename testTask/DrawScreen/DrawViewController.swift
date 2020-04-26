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
    
    var currentColor: Color = Color.white
    var currentColorIndex = 0
    var drawAreaModel: DrawAreaModel!
    var colorizedNodes: [ColorizedNode] = []
    var vc: InfoViewController?
    var visualEffect: UIVisualEffectView!
    
    private let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let boosterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var ananasButton: DrawScreenButton = {
        let button = DrawScreenButton()
        button.setImage(UIImage(named: "086-search"), for: .normal)
        return button
    }()
    
    private let topContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let backButton: DrawScreenButton = {
        let button = DrawScreenButton()
        button.setImage(UIImage(named: "093-back-2"), for: .normal)
        button.addTarget(self, action: #selector(backButtonWasPressed), for: .touchUpInside)
        return button
    }()
    
    private let shopTopView = PaintShopTopView()
    private let paintCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 14)
        label.text = "20k"
        label.textColor = #colorLiteral(red: 0.9098039216, green: 0.262745098, blue: 0.5764705882, alpha: 1)
        return label
    }()
    
    private let goToShopButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "091-plus-1"), for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.addTarget(self, action: #selector(magicStickInfoButtonWasPressed), for: .touchUpInside)
        return button
    }()
    
    private let settingsButton: DrawScreenButton = {
        let button = DrawScreenButton()
        button.setImage(UIImage(named: "100-gear"), for: .normal)
        //button.addTarget(self, action: #selector(magicStickButtonWasPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var magicStickButton: DrawScreenButton = {
        let button = DrawScreenButton()
        button.setImage(UIImage(named: "magic stick"), for: .normal)
        button.addTarget(self, action: #selector(magicStickButtonWasPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var magicStickInfoButton: UIButton = {
        let button = UIButton()
        //button.setImage(UIImage(named: "magic stick"), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.393315196, green: 0.2743449807, blue: 0.8032925725, alpha: 1)
        button.layer.cornerRadius = 9
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(magicStickInfoButtonWasPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var loupeButton: DrawScreenButton = {
        let button = DrawScreenButton()
        button.setImage(UIImage(named: "magic search"), for: .normal)
        button.addTarget(self, action: #selector(loupeButtonWasPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var drawArea: SVGView = {
        let svgView = SVGView()
        svgView.translatesAutoresizingMaskIntoConstraints = false
        svgView.backgroundColor = .white
        svgView.fileName = drawAreaModel.imagePathWithoutNumbers
        svgView.contentMode = .scaleAspectFit
        return svgView
    }()
    
    private lazy var colorCollectionViewPicker: ColorCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 34)
        let collectionView = ColorCollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.layer.cornerRadius = 25
        collectionView.isUserInteractionEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ColorCollectionViewPickerCell.self,
                                forCellWithReuseIdentifier: "ColorCell")
        return collectionView
    }()
    
    let semaphore = DispatchSemaphore(value: 1)
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        drawArea.fileName = drawAreaModel.imagePathWithNumbers
        setActionsToNodes()
        layoutBottomView()
        layoutCollectionView()
        layoutBoosterView()
        layoutAnanasButton()
        layoutLoupeButton()
        layoutMagicWandButton()
        layoutMagicStickInfoButton()
        layoutTopContentView()
        layoutDrawArea()
        getAllColorizedTags()
    }
    
    @objc private func magicStickButtonWasPressed() {
        for valueTag in 1...drawAreaModel.nodes[currentColorIndex] {
            let tag = "\(currentColorIndex+1)_\(valueTag)"
            if isColorizedNodesContains(nodeTag: tag) { continue }
            changeNodeColor(pathTag: tag, withColor: currentColor)
            let colorizedNode = ColorizedNode(colorTag: currentColorIndex+1, tag: tag)
            colorizedNodes.append(colorizedNode)
            saveColorizedNode(node: colorizedNode)
        }
    }
    
    @objc private func loupeButtonWasPressed() {
        for valueTag in 1...drawAreaModel.nodes[currentColorIndex] {
            let tag = "\(currentColorIndex+1)_\(valueTag)"
            if isColorizedNodesContains(nodeTag: tag) { continue }
            changeNodeColor(pathTag: tag, withColor: Color.rgba(r: 174, g: 174, b: 174, a: 0.5))
        }
    }
    
    @objc private func backButtonWasPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func magicStickInfoButtonWasPressed() {
        
        let blure = UIBlurEffect(style: .light)
        visualEffect = UIVisualEffectView(effect: blure)
        visualEffect.alpha = 0
        visualEffect.frame = view.frame
        view.addSubview(visualEffect)
        
        vc = InfoViewController()
        vc!.delegate = self
        vc!.view.frame = UIApplication.shared.windows[0].frame
        vc!.didMove(toParent: self)
        vc!.view.alpha = 0
        self.addChild(vc!)
        self.view.addSubview(vc!.view)
        
        UIView.animate(withDuration: 0.6) { [unowned self] in
            self.vc!.view.alpha = 1
            self.visualEffect.alpha = 0.6
        }
    }
    
    private func getAllColorizedTags() {
        let dispatchWorkItem = DispatchWorkItem(qos: .userInteractive) { [unowned self] in
            guard let nodes = UserDefaultsManager.shared.getProgress(drawId: self.drawAreaModel.id) else { return }
            self.colorizedNodes = nodes
        }
        DispatchQueue.global(qos: .userInteractive).async(execute: dispatchWorkItem)
        dispatchWorkItem.notify(queue: .main) { [unowned self] in
            if !self.colorizedNodes.isEmpty {
                self.colorizeAllSavedAreas()
            }
        }
    }
    
    private func colorizeAllSavedAreas() {
        for node in colorizedNodes {
            let color = drawAreaModel.correctColors[node.colorTag]
            changeNodeColor(pathTag: node.tag, withColor: color)
        }
    }
    
    private func saveColorizedNode(node: ColorizedNode) {
        DispatchQueue.global(qos: .background).async { [unowned self] in
            self.semaphore.wait()
            UserDefaultsManager.shared.saveProgress(drawId: self.drawAreaModel.id, colorizedTags: self.colorizedNodes)
            self.semaphore.signal()
        }
    }
    
    private func setActionsToNodes() {
        
        for pathTag in 1...drawAreaModel.nodes.count {
            for valueTag in 1...drawAreaModel.nodes[pathTag-1] {
                let tag = "\(pathTag)_\(valueTag)"
                if isColorizedNodesContains(nodeTag: tag) { continue }
                drawArea.node.nodeBy(tag: tag)?.onTouchPressed({ (touch) in
                    self.changeNodeColor(pathTag: pathTag-1, fullNodeTag: tag)
                })
            }
        }
    }
    
    private func changeNodeColor(pathTag: String, withColor color: Color) {
        guard let nodeShape = drawArea.node.nodeBy(tag: pathTag) as? Shape else { return }
        nodeShape.fill = color
    }
    
    private func changeNodeColor(pathTag: Int, fullNodeTag: String) {
        if drawAreaModel.correctColors[pathTag] == currentColor && !isColorizedNodesContains(nodeTag: fullNodeTag) {
            let nodeShape = drawArea.node.nodeBy(tag: fullNodeTag) as! Shape
            nodeShape.fill = currentColor
            let colorizedNode = ColorizedNode(colorTag: pathTag, tag: fullNodeTag)
            colorizedNodes.append(colorizedNode)
            saveColorizedNode(node: colorizedNode)
        }
    }
    
    private func isColorizedNodesContains(nodeTag: String) -> Bool {
        var flag = false
        for node in colorizedNodes {
            if node == nodeTag {
                flag = true
                break
            }
        }
        return flag
    }
    
    private func layoutMagicStickInfoButton() {
        magicStickButton.addSubview(magicStickInfoButton)
        magicStickInfoButton.centerXAnchor.constraint(equalTo: magicStickButton.centerXAnchor, constant: 16).isActive = true
        magicStickInfoButton.centerYAnchor.constraint(equalTo: magicStickButton.centerYAnchor, constant: -16).isActive = true
        magicStickInfoButton.heightAnchor.constraint(equalToConstant: 18).isActive = true
        magicStickInfoButton.widthAnchor.constraint(equalToConstant: 18).isActive = true
    }
    
    private func layoutAnanasButton() {
        boosterView.addSubview(ananasButton)
        ananasButton.leadingAnchor.constraint(equalTo: boosterView.leadingAnchor).isActive = true
        ananasButton.topAnchor.constraint(equalTo: boosterView.topAnchor).isActive = true
        ananasButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        ananasButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func layoutLoupeButton() {
        boosterView.addSubview(loupeButton)
        loupeButton.trailingAnchor.constraint(equalTo: boosterView.trailingAnchor).isActive = true
        loupeButton.topAnchor.constraint(equalTo: boosterView.topAnchor).isActive = true
        loupeButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        loupeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func layoutMagicWandButton() {
        boosterView.addSubview(magicStickButton)
        magicStickButton.trailingAnchor.constraint(equalTo: loupeButton.leadingAnchor, constant: -15).isActive = true
        magicStickButton.topAnchor.constraint(equalTo: boosterView.topAnchor).isActive = true
        magicStickButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        magicStickButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func layoutCollectionView() {
        bottomView.addSubview(colorCollectionViewPicker)
        colorCollectionViewPicker.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -12).isActive = true
        colorCollectionViewPicker.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: 20).isActive = true
        colorCollectionViewPicker.heightAnchor.constraint(equalToConstant: 50).isActive = true
        colorCollectionViewPicker.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 1).isActive = true
    }
    
    private func layoutBottomView() {
        view.addSubview(bottomView)
        
        bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 127).isActive = true
    }
    
    private func layoutBoosterView() {
        bottomView.addSubview(boosterView)
        boosterView.bottomAnchor.constraint(equalTo: colorCollectionViewPicker.topAnchor, constant: -15).isActive = true
        boosterView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14).isActive = true
        boosterView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        boosterView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14).isActive = true
    }
    
    private func layoutTopContentView() {
        view.addSubview(topContentView)
        topContentView.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        topContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topContentView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        topContentView.addSubview(backButton)
        backButton.leadingAnchor.constraint(equalTo: topContentView.leadingAnchor, constant: 15).isActive = true
        backButton.topAnchor.constraint(equalTo: topContentView.topAnchor).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        topContentView.addSubview(settingsButton)
        settingsButton.trailingAnchor.constraint(equalTo: topContentView.trailingAnchor, constant: -15).isActive = true
        settingsButton.topAnchor.constraint(equalTo: topContentView.topAnchor).isActive = true
        settingsButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        topContentView.addSubview(shopTopView)
        shopTopView.centerXAnchor.constraint(equalTo: topContentView.centerXAnchor).isActive = true
        shopTopView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        shopTopView.topAnchor.constraint(equalTo: topContentView.topAnchor).isActive = true
        
        let paintImageView = UIImageView(image: UIImage(named: "paint24"))
        paintImageView.translatesAutoresizingMaskIntoConstraints = false
        
        shopTopView.addSubview(paintImageView)
        paintImageView.leadingAnchor.constraint(equalTo: shopTopView.leadingAnchor, constant: 13).isActive = true
        paintImageView.centerYAnchor.constraint(equalTo: shopTopView.centerYAnchor).isActive = true
        paintImageView.bottomAnchor.constraint(equalTo: shopTopView.bottomAnchor, constant: -13).isActive = true
        
        shopTopView.addSubview(paintCountLabel)
        paintCountLabel.centerXAnchor.constraint(equalTo: shopTopView.centerXAnchor).isActive = true
        paintCountLabel.centerYAnchor.constraint(equalTo: shopTopView.centerYAnchor).isActive = true
        
        shopTopView.addSubview(goToShopButton)
        goToShopButton.centerYAnchor.constraint(equalTo: shopTopView.centerYAnchor).isActive = true
        goToShopButton.trailingAnchor.constraint(equalTo: shopTopView.trailingAnchor, constant: -13).isActive = true
        
    }
    
    private func layoutDrawArea() {
        view.addSubview(drawArea)
        drawArea.topAnchor.constraint(equalTo: topContentView.bottomAnchor, constant: 34).isActive = true
        drawArea.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        drawArea.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        drawArea.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
    }
}

extension DrawViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 25, height: 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drawAreaModel.correctColors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell",
                                                      for: indexPath) as! ColorCollectionViewPickerCell
        let color = drawAreaModel.correctColors[indexPath.row]
        cell.setImageColor(color: color, number: indexPath.row+1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentColor = drawAreaModel.correctColors[indexPath.row]
        currentColorIndex = indexPath.row
    }
    
}

class ColorCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5.0)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        
    }
}


extension UICollectionView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

class DrawScreenButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 25
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5.0)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension DrawViewController: InfoViewControllerDelegate {
    func closeInfoScreen() {
        guard let vc = vc else { return }
        UIView.animate(withDuration: 0.6, animations: { [unowned self] in
            vc.view.alpha = 0
            self.visualEffect.alpha = 0
        }) {  [unowned self] (_) in
            vc.willMove(toParent: nil)
            vc.view.removeFromSuperview()
            vc.removeFromParent()
            self.vc = nil
            
            self.visualEffect.removeFromSuperview()
        }
    }
}

class PaintShopTopView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 25
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5.0)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
    }
}
