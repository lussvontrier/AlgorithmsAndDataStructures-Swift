//
//  LexicographicalSort.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 01.12.22.
//

import Foundation

extension Array where Element == Int {
    
    private var maxDigits: Int {
        self.max()?.digits ?? 0
    }
    
    mutating func lexicographicalSort() {
        self = msdRadixSort(self, 0)
    }

    private func msdRadixSort(_ array: [Int], _ position: Int) -> [Int] {
        
        guard position < array.maxDigits else { return array }
        
        var buckets: [[Int]] = .init(repeating: [], count: 10)
        var priorityBucket: [Int] = []
        
        array.forEach { number in
            guard let digit = number.digit(atPosition: position) else {
                priorityBucket.append(number)
                return
            }
            buckets[digit].append(number)
        }
        
        priorityBucket.append(contentsOf: buckets.reduce(into: []) {
            result, bucket in
            
            guard !bucket.isEmpty else { return }
            result.append(contentsOf: msdRadixSort(bucket, position + 1))
        })
            
        return priorityBucket
    }
}

extension Int {
    var digits: Int {
        var count = 0
        var number = self
        while number != 0 {
            count += 1
            number /= 10
        }
        return count
    }
    
    func digit(atPosition position: Int) -> Int? {
        guard position < self.digits else { return nil }
        var number = self
        let adjustedPosition = Double(position + 1)
        
        while number / Int(pow(10, adjustedPosition)) != 0 {
            number /= 10
        }
        return number % 10
    }
}
