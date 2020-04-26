//
//  ViewController.swift
//  testTask
//
//  Created by Роман Важник on 22.04.2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 70, right: 0)
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
    
    private func layoutTopView() {
        view.addSubview(topView)
        topView.addSubview(topViewLabel)
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 72).isActive = true
        
        
        topViewLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        topViewLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 28).isActive = true
    }
    
    private func layoutTableView() {
        tableView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, CatalogTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catalogCell", for: indexPath) as! CatalogTableViewCell
        cell.setupElements(textForTitle: "title", titleImage: UIImage(named: "072-flower-1")!)
        cell.delegate = self
        return cell
    }
    
    func showDrawScreen(at index: Int) {
        let dataImage = data[index]
        let vc = DrawViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.drawAreaModel = dataImage
        self.present(vc, animated: true, completion: nil)
    }
}

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let point = touches.first?.location(in: view) else { return }
//        
//    }
//    
//    func fillArea(in point: CGPoint) {
//        var queue = Queue<[Int]>()
//        queue.append(value: [Int(point.y), Int(point.x)])
//        while !queue.isEmpty {
//            let element = queue.removeLast()!
//            for i in (element.last!-1...element.last!+1) {
//                for j in (element.first!-1...element.first!+1) {
//                    if image!.getPixelColor(pos: CGPoint(x: i, y: j)) == .white {
//                        queue.append(value: [j, i])
//                    }
//                }
//            }
//        }
//    }
//    
//    func drawPixel() {
//    }
//    
//}
//
////class customImage: UIImageView {
////    override func draw(_ rect: CGRect) {
////        guard let context = UIGraphicsGetCurrentContext() else { return }
////        let startPonint = CGPoint(x: 40, y: 100)
////    }
////}
//
//extension UIImage {
//    
//    func getPixelColor(pos: CGPoint) -> UIColor {
//
//        let pixelData = self.cgImage!.dataProvider!.data
//        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
//
//        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
//
//        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
//        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
//        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
//
//        return rgbToHue(r: r, g: g, b: b)
//    }
//    
//    func rgbToHue(r:CGFloat,g:CGFloat,b:CGFloat) -> UIColor {
//        let minV:CGFloat = CGFloat(min(r, g, b))
//        let maxV:CGFloat = CGFloat(max(r, g, b))
//        let delta:CGFloat = maxV - minV
//        var hue:CGFloat = 0
//        if delta != 0 {
//            if r == maxV {
//                hue = (g - b) / delta
//            }
//            else if g == maxV {
//                hue = 2 + (b - r) / delta
//            }
//            else {
//                hue = 4 + (r - g) / delta
//            }
//            hue *= 60
//            if hue < 0 {
//                hue += 360
//            }
//        }
//        let saturation = maxV == 0 ? 0 : (delta / maxV)
//        let brightness = maxV
//        if brightness == 100 && saturation == 0 {
//            return .white
//        } else if brightness == 0 {
//            return .black
//        }
//        if (hue >= 330 && hue <= 360) || (hue >= 0 && hue <= 30) {
//            return .red
//        } else if (hue > 30 && hue <= 55) {
//            return .orange
//        } else if (hue > 55 && hue <= 70) {
//            return .yellow
//        } else if (hue > 70 && hue <= 170) {
//            return #colorLiteral(red: 0.4540862827, green: 1, blue: 0.9686274529, alpha: 1)
//        } else if (hue > 170 && hue <= 260) {
//            return .blue
//        } else if (hue > 260 && hue < 330) {
//            return .purple
//        }
//        return .white
//    }
//
//}
//
//extension UIColor {
//  static func == (l: UIColor, r: UIColor) -> Bool {
//    var r1: CGFloat = 0
//    var g1: CGFloat = 0
//    var b1: CGFloat = 0
//    var a1: CGFloat = 0
//    l.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
//    var r2: CGFloat = 0
//    var g2: CGFloat = 0
//    var b2: CGFloat = 0
//    var a2: CGFloat = 0
//    r.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
//    return r1 == r2 && g1 == g2 && b1 == b2 && a1 == a2
//  }
//}
//func == (l: UIColor?, r: UIColor?) -> Bool {
//  let l = l ?? .clear
//  let r = r ?? .clear
//  return l == r
//}
