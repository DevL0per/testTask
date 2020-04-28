//
//  ViewController.swift
//  testTask
//
//  Created by Роман Важник on 22.04.2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

fileprivate struct Constants {
    static let tableViewCellHeight: CGFloat = 190
    static let bottomInset: CGFloat = 70
    static let topViewHeight: CGFloat = 72
}

class ViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: Constants.bottomInset, right: 0)
        tableView.register(CatalogTableViewCell.self, forCellReuseIdentifier: "catalogCell")
        return tableView
    }()
    private let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let topViewLabel: UILabel = {
        let label = UILabel()
        label.text = "EXPLORE"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 14)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        layoutTopView()
        layoutTableView()
    }
    
    // MARK: - Elemens Layouts
    private func layoutTopView() {
        view.addSubview(topView)
        topView.addSubview(topViewLabel)
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        
        topViewLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        let margins = view.layoutMarginsGuide
        topViewLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10).isActive = true
    }
    
    private func layoutTableView() {
        tableView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
}

// MARK: - UITableView(Delegate, DataSource)
extension ViewController: UITableViewDelegate, UITableViewDataSource, CatalogTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drawsSections.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.tableViewCellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catalogCell", for: indexPath) as! CatalogTableViewCell
        let drawsSection = drawsSections[indexPath.row]
        cell.setupElements(textForTitle: drawsSection.nameOfSection,
                           titleImage: drawsSection.icon)
        cell.delegate = self
        cell.draws = drawsSection.draws
        cell.numberOfSection = indexPath.row
        cell.selectionStyle = .none
        return cell
    }
    
    // CatalogTableViewCellDelegate method
    func showDrawScreen(at index: Int, section: Int) {
        let dataImage = drawsSections[section].draws[index]
        let vc = DrawViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.drawAreaModel = dataImage
        self.present(vc, animated: true, completion: nil)
    }
  
}
