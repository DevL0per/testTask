//
//  DrawViewController.swift
//  testTask
//
//  Created by Роман Важник on 23.04.2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit
import Macaw

fileprivate struct Constants {
    static let paintCost = 1000
    static let magicStickCost = 5000
    static let magicLoupeCost = 3000
    static let buttonSize: CGFloat = 50
    static let bottomViewWidth: CGFloat = 128
    static let contentViewHeight: CGFloat = 50
    static let shopTopViewWidth: CGFloat = 160
}

class DrawViewController: UIViewController {
    
    var drawAreaModel: DrawAreaModel!
    var colorizedNodes: [ColorizedNode] = []
    var hasUserTappedOnTheBoosters = false
    
    // current chosen color
    private var currentColor: Color = Color.white
    // current chosen colorIndex
    private var currentColorIndex = 0
    private var vc: InfoViewController?
    // blure effect when InfoViewController will be shown
    private var visualEffect: UIVisualEffectView!
    
    // MARK: - Properties
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
    private lazy var ananasButton: ButtonWithShadow = {
        let button = ButtonWithShadow()
        button.setImage(UIImage(named: "086-search"), for: .normal)
        button.setImage(UIImage(named: "086-searchSelected"), for: .highlighted)
        button.addTarget(self, action: #selector(ananasButtonWasPressed), for: .touchUpInside)
        return button
    }()
    private let topContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let backButton: ButtonWithShadow = {
        let button = ButtonWithShadow()
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.setImage(UIImage(named: "backButtonSelected"), for: .highlighted)
        button.addTarget(self, action: #selector(backButtonWasPressed), for: .touchUpInside)
        return button
    }()
    private let shopTopView: ViewWithShadow = {
        let view = ViewWithShadow()
        view.layer.cornerRadius = 25
        return view
    }()
    private let paintCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 14)
        label.textColor = #colorLiteral(red: 0.9098039216, green: 0.262745098, blue: 0.5764705882, alpha: 1)
        return label
    }()
    private let goToShopButton: GoToShopButton = {
        let button = GoToShopButton()
        button.setImage(UIImage(named: "091-plus-1"), for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showShop), for: .touchUpInside)
        return button
    }()
    private let settingsButton: ButtonWithShadow = {
        let button = ButtonWithShadow()
        button.setImage(UIImage(named: "100-gear"), for: .normal)
        return button
    }()
    private lazy var magicStickButton: ButtonWithShadow = {
        let button = ButtonWithShadow()
        button.setImage(UIImage(named: "magic stick"), for: .normal)
        button.setImage(UIImage(named: "magic stickSelected"), for: .highlighted)
        button.addTarget(self, action: #selector(magicStickButtonWasPressed), for: .touchUpInside)
        return button
    }()
    private lazy var magicStickInfoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.393315196, green: 0.2743449807, blue: 0.8032925725, alpha: 1)
        button.layer.cornerRadius = 9
        button.layer.masksToBounds = true
        button.setImage(UIImage(named: "iIcon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(magicStickInfoButtonWasPressed), for: .touchUpInside)
        return button
    }()
    private lazy var loupeButton: ButtonWithShadow = {
        let button = ButtonWithShadow()
        button.setImage(UIImage(named: "magic search"), for: .normal)
        button.setImage(UIImage(named: "magic searchSelected"), for: .highlighted)
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
    private lazy var colorCollectionViewPicker: CollectionViewWithShadow = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 34)
        let collectionView = CollectionViewWithShadow(frame: .zero,
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
    private var numberOfPaints: Int! {
        didSet {
            paintCountLabel.text = ConvertNumberManager.shared.convertNumberOfPaintsToString(number: numberOfPaints)
        }
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        view.backgroundColor = .white
        numberOfPaints = 20000
        drawArea.fileName = drawAreaModel.imagePathWithNumbers
        setActionsToNodes()
        layoutElements()
        checkIfUserTappedOnTheBooster()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getNumberOfPaints()
    }
    
    
    //Buttons actions
    @objc private func showShop() {
        let vc = ShopViewController()
        vc.drawId = drawAreaModel.id
        vc.numberOfPaints = numberOfPaints
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc private func magicStickButtonWasPressed() {
        if !hasUserTappedOnTheBoosters {
            magicStickInfoButtonWasPressed()
            UserDefaultsManager.shared.userTapOnTheBoosterForTheFirstTime()
            hasUserTappedOnTheBoosters = true
        } else {
            // find all nodes with certain tag and colorize it
            if numberOfPaints >= Constants.magicStickCost {
                for valueTag in 1...drawAreaModel.nodes[currentColorIndex] {
                    let tag = "\(currentColorIndex+1)_\(valueTag)"
                    if isColorizedNodesContains(nodeTag: tag) { continue }
                    changeNodeColor(pathTag: tag, withColor: currentColor)
                    let colorizedNode = ColorizedNode(colorTag: currentColorIndex, tag: tag)
                    colorizedNodes.append(colorizedNode)
                    let cell = colorCollectionViewPicker.cellForItem(at:
                        IndexPath(item: currentColorIndex, section: 0)) as! ColorCollectionViewPickerCell
                    cell.nodeWasColorized()
                }
                numberOfPaints-=Constants.magicStickCost
                saveColorizedNode()
            }
        }
    }
    
    @objc private func ananasButtonWasPressed() {
        if !hasUserTappedOnTheBoosters {
            magicStickInfoButtonWasPressed()
            UserDefaultsManager.shared.userTapOnTheBoosterForTheFirstTime()
            hasUserTappedOnTheBoosters = true
        }
    }
    
    @objc private func loupeButtonWasPressed() {
        if !hasUserTappedOnTheBoosters {
            magicStickInfoButtonWasPressed()
            UserDefaultsManager.shared.userTapOnTheBoosterForTheFirstTime()
            hasUserTappedOnTheBoosters = true
        } else {
            if numberOfPaints >= Constants.magicLoupeCost {
                for valueTag in 1...drawAreaModel.nodes[currentColorIndex] {
                    let tag = "\(currentColorIndex+1)_\(valueTag)"
                    if isColorizedNodesContains(nodeTag: tag) { continue }
                    changeNodeColor(pathTag: tag, withColor: Color.rgba(r: 174, g: 174, b: 174, a: 0.5))
                }
                numberOfPaints-=Constants.magicLoupeCost
            }
        }
    }
    
    @objc private func backButtonWasPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func magicStickInfoButtonWasPressed() {
        // add blure on viewController
        let blure = UIBlurEffect(style: .dark)
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
    
    private func layoutElements() {
        layoutBottomView()
        layoutCollectionView()
        layoutBoosterView()
        layoutAnanasButton()
        layoutLoupeButton()
        layoutMagicWandButton()
        layoutMagicStickInfoButton()
        layoutTopContentView()
        layoutDrawArea()
    }
    
    private func checkIfUserTappedOnTheBooster() {
        guard let result = UserDefaultsManager.shared.hasUserTappedOnTheBoosters() else { return }
        hasUserTappedOnTheBoosters = result
    }
    
    // get user's progress in certain painting
    private func getAllColorizedTags() {
        let dispatchWorkItem = DispatchWorkItem(qos: .userInteractive) { [unowned self] in
            guard let nodes = UserDefaultsManager.shared.getProgress(drawId: self.drawAreaModel.id) else { return }
            self.colorizedNodes = nodes
        }
        DispatchQueue.global(qos: .utility).async(execute: dispatchWorkItem)
        dispatchWorkItem.notify(queue: .main) { [unowned self] in
            if !self.colorizedNodes.isEmpty {
                self.colorizeAllSavedAreas()
            }
        }
    }
    
    // get user's number of paints in certain painting
    private func getNumberOfPaints() {
        let dispatchWorkItem = DispatchWorkItem(qos: .userInteractive) { [unowned self] in
            guard let numberOfPaints =
                UserDefaultsManager.shared.getNumberOfPaints(drawId: self.drawAreaModel.id) else { return }
            DispatchQueue.main.async { [unowned self] in
                self.numberOfPaints = numberOfPaints
            }
        }
        DispatchQueue.global(qos: .utility).async(execute: dispatchWorkItem)
    }
    
    // colorize all nodes that user colorized before
    private func colorizeAllSavedAreas() {
        for node in colorizedNodes {
            let color = drawAreaModel.correctColors[node.colorTag]
            changeNodeColor(pathTag: node.tag, withColor: color)
            let cell = colorCollectionViewPicker.cellForItem(at:
                IndexPath(item: node.colorTag, section: 0)) as! ColorCollectionViewPickerCell
            cell.nodeWasColorized()
        }
    }
    
    // save all current colorized nodes
    private func saveColorizedNode() {
        DispatchQueue.global(qos: .utility).async { [unowned self] in
            self.semaphore.wait()
            UserDefaultsManager.shared.saveProgress(drawId: self.drawAreaModel.id, colorizedTags: self.colorizedNodes, numberOfPaints: self.numberOfPaints)
            self.semaphore.signal()
        }
    }
    
    // set actions to all nodes
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
    
    // fill certain node with color
    private func changeNodeColor(pathTag: String, withColor color: Color) {
        guard let nodeShape = drawArea.node.nodeBy(tag: pathTag) as? Shape else { return }
        nodeShape.fill = color
    }
    
    // node action (user has tapped to certain node)
    private func changeNodeColor(pathTag: Int, fullNodeTag: String) {
        // if collor is correct and node is't colorized fill it
        if drawAreaModel.correctColors[pathTag] == currentColor
            && !isColorizedNodesContains(nodeTag: fullNodeTag) && numberOfPaints >= Constants.paintCost {
            changeNodeColor(pathTag: fullNodeTag, withColor: currentColor)
            let colorizedNode = ColorizedNode(colorTag: pathTag, tag: fullNodeTag)
            colorizedNodes.append(colorizedNode)
            saveColorizedNode()
            // tell UICollectionViewCell that node was colorized
            let cell = colorCollectionViewPicker.cellForItem(at:
                IndexPath(item: currentColorIndex, section: 0)) as! ColorCollectionViewPickerCell
            cell.nodeWasColorized()
            numberOfPaints-=Constants.paintCost
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
    
    // MARK: - Elements layout
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
        ananasButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize).isActive = true
        ananasButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize).isActive = true
    }
    
    private func layoutLoupeButton() {
        boosterView.addSubview(loupeButton)
        loupeButton.trailingAnchor.constraint(equalTo: boosterView.trailingAnchor).isActive = true
        loupeButton.topAnchor.constraint(equalTo: boosterView.topAnchor).isActive = true
        loupeButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize).isActive = true
        loupeButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize).isActive = true
    }
    
    private func layoutMagicWandButton() {
        boosterView.addSubview(magicStickButton)
        magicStickButton.trailingAnchor.constraint(equalTo: loupeButton.leadingAnchor, constant: -15).isActive = true
        magicStickButton.topAnchor.constraint(equalTo: boosterView.topAnchor).isActive = true
        magicStickButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize).isActive = true
        magicStickButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize).isActive = true
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
        bottomView.heightAnchor.constraint(equalToConstant: Constants.bottomViewWidth).isActive = true
    }
    
    private func layoutBoosterView() {
        bottomView.addSubview(boosterView)
        boosterView.bottomAnchor.constraint(equalTo: colorCollectionViewPicker.topAnchor, constant: -15).isActive = true
        boosterView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14).isActive = true
        boosterView.heightAnchor.constraint(equalToConstant: Constants.contentViewHeight).isActive = true
        boosterView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14).isActive = true
    }
    
    private func layoutTopContentView() {
        view.addSubview(topContentView)
        topContentView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        topContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topContentView.heightAnchor.constraint(equalToConstant: Constants.contentViewHeight).isActive = true
        
        topContentView.addSubview(backButton)
        backButton.leadingAnchor.constraint(equalTo: topContentView.leadingAnchor, constant: 15).isActive = true
        backButton.topAnchor.constraint(equalTo: topContentView.topAnchor).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize).isActive = true
        
        topContentView.addSubview(settingsButton)
        settingsButton.trailingAnchor.constraint(equalTo: topContentView.trailingAnchor, constant: -15).isActive = true
        settingsButton.topAnchor.constraint(equalTo: topContentView.topAnchor).isActive = true
        settingsButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize).isActive = true
        
        topContentView.addSubview(shopTopView)
        shopTopView.centerXAnchor.constraint(equalTo: topContentView.centerXAnchor).isActive = true
        shopTopView.widthAnchor.constraint(equalToConstant: Constants.shopTopViewWidth).isActive = true
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

// MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
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
        let numberOfNodes = drawAreaModel.nodes[indexPath.row]
        cell.setImageColor(color: color, number: indexPath.row+1, numberOfNodes: numberOfNodes)
        if (indexPath.row == drawAreaModel.correctColors.count-1) { getAllColorizedTags() }
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

// MARK: - InfoViewControllerDelegate
// remove blure effect and infoVC
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
