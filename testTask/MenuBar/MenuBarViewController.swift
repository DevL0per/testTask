//
//  MenuBarViewController.swift
//  testTask
//
//  Created by Роман Важник on 23.04.2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

private struct Constants {
    static let menuBarHeightConstant: CGFloat = 80
}

class MenuBarViewController: UIViewController, MenuBarDelegate {
    
    private var selectedIndex: Int = 0
    private var previousIndex: Int = 0
    private var viewControllers = [UIViewController]()
    
    private let menuBar: MenuBar = {
        let menuBar = MenuBar()
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        return menuBar
    }()
    
    static let firstVC = ViewController()
    static let secondVC = SettingsViewController()
    static let thirdVC = SettingsViewController()
    static let fourthVC = SettingsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBar.delegate = self
        layoutMenuBar()
        viewControllers.append(MenuBarViewController.firstVC)
        viewControllers.append(MenuBarViewController.secondVC)
        viewControllers.append(MenuBarViewController.thirdVC)
        viewControllers.append(MenuBarViewController.fourthVC)
        menuBarWasSelected(at: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func menuBarWasSelected(at index: Int) {
        if index != 0 && index != 3 { return }
        previousIndex = selectedIndex
        selectedIndex = index
        
        let previousVC = viewControllers[previousIndex]
        
        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()
        
        let vc = viewControllers[selectedIndex]
        vc.view.frame = UIApplication.shared.windows[0].frame
        vc.didMove(toParent: self)
        self.addChild(vc)
        self.view.addSubview(vc.view)
        
        self.view.bringSubviewToFront(menuBar)
    }
    
    // MARK: - Elemens Layouts
    private func layoutMenuBar() {
        view.addSubview(menuBar)
        menuBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: Constants.menuBarHeightConstant).isActive = true
        menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
