//
//  SelectionSort.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 15.11.22.
//

import Foundation

class SelectionSort {
    static func sort<Element>(_ array: inout [Element]) where Element: Comparable {
        guard array.count > 2 else { return }
        
        for current in 0..<(array.count - 1) {
            var min = current
            for i in (current + 1)..<array.count {
                if array[i] < array[min] {
                    min = i
                }
            }
            if min != current {
                array.swapAt(current, min)
            }
        }
    }
}
