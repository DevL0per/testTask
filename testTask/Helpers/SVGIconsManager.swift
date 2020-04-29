//
//  SVGIconsManager.swift
//  testTask
//
//  Created by Роман Важник on 29.04.2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import PocketSVG

class SVGIconsManager {
    
    static let shared = SVGIconsManager()
    
    private func snapshotImage(for layer: CALayer) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.bounds.size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    func setImage(forResourceName: String, size: CGSize, inObject obj: UIImageView) {
        DispatchQueue.global(qos: .background).async {
            let url = Bundle.main.url(forResource: forResourceName , withExtension: "svg")!
            let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            let svgLayer = SVGLayer(contentsOf: url)
            svgLayer.frame = frame
            
            let image = self.snapshotImage(for: svgLayer)
            DispatchQueue.main.async {
                obj.image = image
            }
        }
    }
    
    func returnImage(forResourceName: String, size: CGSize) -> UIImage {
        let url = Bundle.main.url(forResource: forResourceName , withExtension: "svg")!
        let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let svgLayer = SVGLayer(contentsOf: url)
        svgLayer.frame = frame
        
        let image = self.snapshotImage(for: svgLayer)!
        return image
    }
        
}

