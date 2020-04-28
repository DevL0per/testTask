//
//  InfoViewController.swift
//  testTask
//
//  Created by Роман Важник on 26.04.2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

protocol InfoViewControllerDelegate {
    func closeInfoScreen()
}

class InfoViewController: UIViewController {
    
    fileprivate let items: [InfoScreenModel] = [
        InfoScreenModel(image: UIImage(named: "witch96")!,
                        title: "Magic Wand Tool",
                        subtitle: "Color any shape in your\n field of view", drawCost: 5000),
        InfoScreenModel(image: UIImage(named: "smile96")!,
                        title: "Magic Search Tool",
                        subtitle: "Find lost shapes for\n choosen color", drawCost: 3000),
        InfoScreenModel(image: UIImage(named: "search96")!,
                        title: "Zoom Tooll",
                        subtitle: "Discover more details with\n smart zoom", drawCost: 0)
    ]
    
    var delegate: InfoViewControllerDelegate!
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextButtonWasPressed), for: .touchUpInside)
        return button
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.6572092772, green: 0.6525078416, blue: 0.6691473126, alpha: 1)
        return pageControl
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: self.view.frame,
                                              collectionViewLayout: layout)
        collectionView.isUserInteractionEnabled = true
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.register(InfoCollectonViewCell.self,
                                forCellWithReuseIdentifier: "InfoCell")
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.backgroundColor = #colorLiteral(red: 0.1647058824, green: 0.1647058824, blue: 0.1647058824, alpha: 0.9370023885)
        layoutPageControl()
        layoutNextButton()
    }
    
    @objc private func nextButtonWasPressed() {
        let nextIndex = pageControl.currentPage+1
        if nextIndex == items.count {
            delegate.closeInfoScreen()
            return
        }
        let indexPath = IndexPath(item: nextIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage += 1
    }
    
    private func layoutNextButton() {
        collectionView.addSubview(nextButton)
        collectionView.bringSubviewToFront(nextButton)
        nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        nextButton.centerYAnchor.constraint(equalTo: pageControl.centerYAnchor).isActive = true
    }
    
    private func layoutPageControl() {
        view.addSubview(pageControl)
        collectionView.bringSubviewToFront(pageControl)
        pageControl.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
    }
}

// MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension InfoViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoCell", for: indexPath) as! InfoCollectonViewCell
        cell.setupElements(item: items[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
    }
    
}


