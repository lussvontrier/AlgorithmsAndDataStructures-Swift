//
//  Turing.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 18.10.23.
//

import Foundation

class SolutionTuring {
    //O(n)
    func largestDifference(array: [Int]) -> Int {
        guard !array.isEmpty else { return 0 }
        var currentDifference = 0
        var smallestRightNumber = array[0]
        
        for i in 1..<array.count {
            let diff = array[i] - smallestRightNumber
            currentDifference = diff > currentDifference ? diff : currentDifference
            
            smallestRightNumber = array[i] < smallestRightNumber ? array[i] : smallestRightNumber
        }
        
        return currentDifference
    }
    
    func sortedIndices(of array: [Int]) -> [Int] {
        let indexedArray = array.enumerated().map { ($0.element, $0.offset) }
        let sortedIndexedArray = indexedArray.sorted { $0.0 < $1.0 }
        return sortedIndexedArray.map { $0.1 }
    }

}
