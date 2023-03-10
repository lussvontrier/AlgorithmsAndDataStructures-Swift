//
//  QuickSortLomuto.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 10.03.23.
//

import Foundation

///Lomuto’s partitioning algorithm always chooses the last element as the pivot.
public func partitionLomuto<T: Comparable>(_ array: inout [T], low: Int, high: Int) -> Int {
    let pivot = array[high]
    
    var i = low
    
    for j in low..<high {
        if array[j] <= pivot {
            array.swapAt(i, j)
            i += 1
        }
    }
    
    array.swapAt(i, high)
    return i
}

public func quickSortLomuto<T: Comparable>(_ array: inout [T], low: Int, high: Int) {
    if low < high {
        let pivot = partitionLomuto(&array, low: low, high: high)
        quickSortLomuto(&array, low: low, high: pivot-1)
        quickSortLomuto(&array, low: pivot+1, high: high)
    }
}
