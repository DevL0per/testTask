//
//  UserDefaultsManager.swift
//  testTask
//
//  Created by Роман Важник on 26.04.2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit
import Macaw

struct ColorizedNode: Equatable, Codable {
    let colorTag: Int
    let tag: String
    
    static func == (lhs: ColorizedNode, rhs: String) -> Bool {
        return lhs.tag == rhs
    }
}

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    private let defaults = UserDefaults.standard
    
    func saveProgress(drawId: Int, colorizedTags: [ColorizedNode], numberOfPaints: Int) {
        defaults.set(try? PropertyListEncoder().encode(colorizedTags), forKey: String(drawId))
        defaults.set(numberOfPaints, forKey: "numberOfPaints\(drawId)")
    }
    
    func saveNumberOfPaints(drawId: Int, numberOfPaints: Int) {
        defaults.set(numberOfPaints, forKey: "numberOfPaints\(drawId)")
    }
    
    func getNumberOfPaints(drawId: Int) -> Int? {
        return defaults.value(forKey: "numberOfPaints\(drawId)") as? Int
    }
    
    func getProgress(drawId: Int) -> [ColorizedNode]? {
        if let data = defaults.value(forKey: String(drawId)) as? Data {
            let nodes = try? PropertyListDecoder().decode(Array<ColorizedNode>.self, from: data)
            return nodes
        } else {
            return nil
        }
    }
    
    func hasUserTappedOnTheBoosters() -> Bool? {
        return defaults.value(forKey: "hasUserTappedOnTheBoosters") as? Bool
    }
    
    func userTapOnTheBoosterForTheFirstTime() {
        defaults.set(true, forKey: "hasUserTappedOnTheBoosters")
    }
}
