//
//  Data.swift
//  testTask
//
//  Created by Роман Важник on 25.04.2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit
import Macaw


let firstSectionDrawsData: [DrawAreaModel] = [
    DrawAreaModel(id: 1, imagePathWithNumbers: "firstDrawWithNumbers", imagePathWithoutNumbers: "firstDrawNoNumbers",
                  nodes: [22, 43, 5, 8, 49, 7],
                  correctColors: [Color.rgb(r: 45, g: 126, b: 153), Color.blue, Color.green, Color.rgb(r: 247, g: 199, b: 88), Color.rgb(r: 45, g: 126, b: 193), Color.rgb(r: 93, g: 17, b: 247)]),
    DrawAreaModel(id: 2, imagePathWithNumbers: "firstDrawWithNumbers", imagePathWithoutNumbers: "firstDrawNoNumbers",
                  nodes: [22, 43, 5, 8, 49, 7],
                  correctColors: [Color.rgb(r: 45, g: 126, b: 153), Color.blue, Color.green, Color.rgb(r: 247, g: 199, b: 88), Color.rgb(r: 45, g: 126, b: 193), Color.rgb(r: 93, g: 17, b: 247)]),
    DrawAreaModel(id: 3, imagePathWithNumbers: "firstDrawWithNumbers", imagePathWithoutNumbers: "firstDrawNoNumbers",
                  nodes: [22, 43, 5, 8, 49, 7],
                  correctColors: [Color.rgb(r: 45, g: 126, b: 153), Color.blue, Color.green, Color.rgb(r: 247, g: 199, b: 88), Color.rgb(r: 45, g: 126, b: 193), Color.rgb(r: 93, g: 17, b: 247)])
]

let secondSectionDrawsData: [DrawAreaModel] = [
    DrawAreaModel(id: 4, imagePathWithNumbers: "flowers_withNumbers", imagePathWithoutNumbers: "flowers_withoutNumbers",
                  nodes: [1, 7, 4, 1],
                  correctColors: [Color.blue, Color.rgb(r: 247, g: 87, b: 88), Color.green, Color.rgb(r: 62, g: 172, b: 202)]),
    DrawAreaModel(id: 5, imagePathWithNumbers: "flowers_withNumbers", imagePathWithoutNumbers: "flowers_withoutNumbers",
                  nodes: [1, 7, 4, 1],
                  correctColors: [Color.blue, Color.rgb(r: 247, g: 87, b: 88), Color.green, Color.rgb(r: 62, g: 172, b: 202)]),
    DrawAreaModel(id: 6, imagePathWithNumbers: "flowers_withNumbers", imagePathWithoutNumbers: "flowers_withoutNumbers",
                  nodes: [1, 7, 4, 1],
                  correctColors: [Color.blue, Color.rgb(r: 247, g: 87, b: 88), Color.green, Color.rgb(r: 62, g: 172, b: 202)])
]

let thirdSectionDrawsData: [DrawAreaModel] = [
    DrawAreaModel(id: 7, imagePathWithNumbers: "birdWithNumbers", imagePathWithoutNumbers: "birdWithoutNumbers",
                  nodes: [15, 10, 4, 4],
                  correctColors: [Color.rgb(r: 66, g: 193, b: 228), Color.rgb(r: 65, g: 70, b: 125), Color.rgb(r: 205, g: 205, b: 205), Color.red]),
    DrawAreaModel(id: 8, imagePathWithNumbers: "birdWithNumbers", imagePathWithoutNumbers: "birdWithoutNumbers",
                  nodes: [15, 10, 4, 4],
                  correctColors: [Color.rgb(r: 66, g: 193, b: 228), Color.rgb(r: 65, g: 70, b: 125), Color.rgb(r: 205, g: 205, b: 205), Color.red]),
    DrawAreaModel(id: 9, imagePathWithNumbers: "birdWithNumbers", imagePathWithoutNumbers: "birdWithoutNumbers",
                  nodes: [15, 10, 4, 4],
                  correctColors: [Color.rgb(r: 66, g: 193, b: 228), Color.rgb(r: 65, g: 70, b: 125), Color.rgb(r: 205, g: 205, b: 205), Color.red])
]

let drawsSections: [DrawSection] = [
    DrawSection(icon: UIImage(named: "animalsSectionIcon")!, nameOfSection: "ANIMALS", draws: firstSectionDrawsData),
    DrawSection(icon: UIImage(named: "flowerSectionIcon")!, nameOfSection: "FLOWERS", draws: secondSectionDrawsData),
    DrawSection(icon: UIImage(named: "birdsSectionIcon")!, nameOfSection: "BIRDS", draws: thirdSectionDrawsData)
]

