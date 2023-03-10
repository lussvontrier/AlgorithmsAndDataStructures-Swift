//
//  MergeSort.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 15.11.22.
//

import Foundation

class MergeSort {
    static func sort<Element>(_ array: [Element]) -> [Element] where Element: Comparable {
        guard array.count > 1 else { return array }
        let middle = array.count / 2
        let left = sort(Array(array[..<middle]))
        let right = sort(Array(array[middle...]))
        return merge(left, right)
    }
    
    private static func merge<Element>(_ left: [Element], _ right: [Element]) -> [Element] where Element: Comparable {
        var leftIndex = 0
        var rightIndex = 0
        
        var result: [Element] = []
        
        while leftIndex < left.count && rightIndex < right.count {
            if left[leftIndex] < right[rightIndex] {
                result.append(left[leftIndex])
                leftIndex += 1
            } else if right[rightIndex] < left[leftIndex] {
                result.append(right[rightIndex])
                rightIndex += 1
            } else {
                result.append(left[leftIndex])
                leftIndex += 1
                result.append(right[rightIndex])
                rightIndex += 1
            }
        }
        
        if leftIndex < left.count {
            result.append(contentsOf: left[leftIndex...])
        } else if rightIndex < right.count {
            result.append(contentsOf: right[rightIndex...])
        }
        
        return result
    }
}
