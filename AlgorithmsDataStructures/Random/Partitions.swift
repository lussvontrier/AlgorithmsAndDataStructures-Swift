//
//  Partitions.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 08.07.24.
//

import Foundation

class Partitions {
    func numberOfPartitions(array: [Int]) -> Int {
        var encounteredMax = 0
        var partitions = 0
        for i in 0..<array.count {
            encounteredMax = max(encounteredMax, array[i])
            if i == encounteredMax {
                partitions += 1
                encounteredMax = i+1
            }
        }
        return partitions
    }
}
