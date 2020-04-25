//
//  Queue.swift
//  testTask
//
//  Created by Роман Важник on 22.04.2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

//import Foundation
//
//class QueueNode<T> {
//    var value: T
//    var next: QueueNode<T>?
//    init(value: T) {
//        self.value = value
//    }
//}
//
//struct Queue<T>: CustomStringConvertible {
//    private var head: QueueNode<T>?
//    private var first: QueueNode<T>?
//    
//    var isEmpty: Bool {
//        if head != nil {
//            return false
//        } else {
//            return true
//        }
//    }
//    
//    mutating func append(value: T) {
//        let queueNode = QueueNode(value: value)
//        if head != nil {
//            head?.next = queueNode
//        } else {
//            first = queueNode
//        }
//        head = queueNode
//    }
//    
//    mutating func removeLast() -> T? {
//        if head === first {
//            let lastHead = head
//            head = nil
//            first = nil
//            return lastHead?.value
//        } else if head != nil {
//            let lastFirst = first
//            first = first?.next
//            lastFirst?.next = nil
//            return lastFirst?.value
//        } else {
//            return nil
//        }
//    }
//    
//    var description: String {
//        var currentElement = first
//        var result = "["
//        while currentElement != nil {
//            result += "\(currentElement!.value)"
//            currentElement = currentElement?.next
//            if currentElement != nil {
//                result+=", "
//            }
//        }
//        return result + "]"
//    }
//}
