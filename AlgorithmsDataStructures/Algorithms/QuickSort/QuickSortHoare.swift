//
//  QuickSortHoare.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 10.03.23.
//

import Foundation

///Hoare’s partitioning algorithm always chooses the first element as the pivot.
public func partitionHoare<T: Comparable>(_ array: inout [T], low: Int, high: Int) -> Int {
    let pivot = array[low]
    
    var i = low - 1
    var j = high + 1
    
    while true {
        repeat { j -= 1 } while array[j] > pivot
        repeat { i += 1 } while array[i] < pivot
        
        if i < j {
            array.swapAt(i, j)
        } else {
            return j
        }
    }
}

public func quickSortHoare<T: Comparable>(_ array: inout [T], low: Int, high: Int) {
    if low < high {
        let pivot = partitionHoare(&array, low: low, high: high)
        quickSortHoare(&array, low: low, high: pivot)
        quickSortHoare(&array, low: pivot + 1, high: high)
    }

}
