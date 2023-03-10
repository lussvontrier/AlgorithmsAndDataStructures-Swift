//
//  Challenges.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 15.11.22.
//

import Foundation

extension MutableCollection where Self: BidirectionalCollection, Element: Equatable {
    mutating func rightAlign(value: Element) {
        var left = startIndex
        var right = index(before: endIndex)
        while left < right {
            while self[right] == value {
                formIndex(before: &right)
            }
            while self[left] != value {
                formIndex(after: &left)
            }
            guard left < right else {
                return
            }
            swapAt(left, right)
        }
    }
}

extension Sequence where Element: Hashable {
    var firstDuplicate: Element? {
        var found: Set<Element> = []
        for value in self {
            if found.contains(value) {
                return value
            } else {
                found.insert(value)
            }
        }
        return nil
    }
}

extension MutableCollection where Self: BidirectionalCollection {
    mutating func reverse() {
        var left = startIndex
        var right = index(before: endIndex)
        
        while left < right {
            self.swapAt(left, right)
            formIndex(before: &right)
            formIndex(after: &left)
        }
    }
}
