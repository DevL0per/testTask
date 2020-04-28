//
//  DrawAreaData.swift
//  testTask
//
//  Created by Роман Важник on 25.04.2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit
import Macaw

struct DrawAreaModel {
    var id: Int
    var imagePathWithNumbers: String
    var imagePathWithoutNumbers: String
    var nodes: [Int] = []
    var correctColors: [Color] = []
}

struct DrawSection {
    var icon: UIImage
    var nameOfSection: String
    var draws: [DrawAreaModel]
}
