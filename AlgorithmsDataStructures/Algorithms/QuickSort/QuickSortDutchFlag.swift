//
//  QuickSortDutchFlag.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 10.03.23.
//

import Foundation

public func partitionDutchFlag<T: Comparable>(_ array: inout [T], low: Int, high: Int, pivotIndex: Int) -> (Int, Int) {
    
    let pivot = array[pivotIndex]
    var smaller = low
    var equal = low
    var larger = high
    
    while equal <= larger {
        if array[equal] < pivot {
            array.swapAt(equal, smaller)
            equal += 1
            smaller += 1
        } else if array[equal] == pivot {
            equal += 1
        } else {
            array.swapAt(equal, larger)
            larger -= 1
        }
        
    }
    return (smaller, larger)
}


public func quickSortDutchFlag<T: Comparable>(_ array: inout [T], low: Int, high: Int) {
    if low < high {
        let (middleFirst, middleLast) = partitionDutchFlag(&array, low: low, high: high, pivotIndex: high)
        quickSortDutchFlag(&array, low: low, high: middleFirst - 1)
        quickSortDutchFlag(&array, low: middleLast + 1, high: high)
    }
}
