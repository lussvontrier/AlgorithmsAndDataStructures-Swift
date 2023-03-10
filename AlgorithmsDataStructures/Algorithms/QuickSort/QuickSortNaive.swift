//
//  QuickSortNaive.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 10.03.23.
//

import Foundation

///Naive partitioning algorithm always chooses the middle element as the pivot.
public func quickSortNaive<T: Comparable>(_ array: [T]) -> [T] {
    guard array.count > 1 else { return array }
    
    let pivot = array[array.count / 2]
    
    let less = array.filter { $0 < pivot }
    let equal = array.filter { $0 == pivot }
    let greater = array.filter { $0 > pivot }
    
    return quickSortNaive(less) + equal + quickSortNaive(greater)
}
