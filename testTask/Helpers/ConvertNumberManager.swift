//
//  ConvertNumberManager.swift
//  testTask
//
//  Created by Роман Важник on 27.04.2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import Foundation

class ConvertNumberManager {
    static let shared = ConvertNumberManager()
    
    func convertNumberOfPaintsToString(number: Int) -> String {
        var stringNumber = String(number)
        if stringNumber.count == 4 || stringNumber.count == 5 || stringNumber.count == 6 {
            stringNumber = String(stringNumber.dropLast(3))
            stringNumber+="k"
        } else if stringNumber.count >= 7 {
            stringNumber = String(stringNumber.dropLast(5))
            stringNumber+="m"
        }
        return stringNumber
    }
}
