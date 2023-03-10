//
//  QuickSortMedian.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 10.03.23.
//

import Foundation

///Find the median of the first, middle and last element in the array and use that as a pivot. This selection strategy prevents you from picking the highest or lowest element in the array that can result in worst-case scenario of O(n^2)
public func medianOfThree<T: Comparable>(_ array: inout [T], low: Int, high: Int) -> Int {
    let center = (low + high) / 2
    if array[low] > array[center] {
        array.swapAt(low, center)
    }
    if array[low] > array[high] {
        array.swapAt(low, high)
    }
    if array[center] > array[high] {
        array.swapAt(center, high)
    }
    return center
}

public func quickSortMedian<T: Comparable>(_ array: inout [T], low: Int, high: Int) {
    if low < high {
        let pivotIndex = medianOfThree(&array, low: low, high: high)
        array.swapAt(pivotIndex, high)
        let pivot = partitionLomuto(&array, low: low, high: high)
        quickSortLomuto(&array, low: low, high: pivot - 1)
        quickSortLomuto(&array, low: pivot + 1, high: high)
    }
}
