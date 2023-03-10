//
//  InsertionSort.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 15.11.22.
//

import Foundation

class InsertionSort {
    static func sort<Element>(_ array: inout [Element]) where Element: Comparable {
        guard array.count > 2 else { return }
        
        for current in 1..<array.count {
            var candidateToShift = current
            while array[candidateToShift] < array[candidateToShift - 1] {
                array.swapAt(candidateToShift, candidateToShift - 1)
                candidateToShift = candidateToShift - 1
            }
        }
    }
}
