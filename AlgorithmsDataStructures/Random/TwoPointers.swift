//
//  TwoPointers.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 09.07.24.
//

import Foundation

/// **O(n^2) Two Pointers
func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
    // Sort the array to use the two-pointer technique
    let sortedNums = nums.sorted()
    let n = sortedNums.count
    var closestSum = sortedNums[0] + sortedNums[1] + sortedNums[2]
    
    for i in 0..<(n-2) {
        var left = i + 1
        var right = n - 1
        
        while left < right {
            let currentSum = sortedNums[i] + sortedNums[left] + sortedNums[right]
            
            // Update the closestSum if the currentSum is closer to the target
            if abs(currentSum - target) < abs(closestSum - target) {
                closestSum = currentSum
            }
            
            if currentSum < target {
                left += 1
            } else if currentSum > target {
                right -= 1
            } else {
                // If the currentSum is exactly equal to the target
                return currentSum
            }
        }
    }
    
    return closestSum
}

/// **O(n) One Pointer
func longestSubarrayOfOnes(_ array: [Int]) -> Int {
    let count = array.count
    var maxLength = 0
    var currentLength = 0

    for right in 0..<count {
        if array[right] == 1 {
            currentLength += 1
        } else {
            maxLength = max(currentLength, maxLength)
            currentLength = 0
        }
    }

    maxLength = max(currentLength, maxLength)
    return maxLength
}

/// **O(n) One Pointer
/// Find the minimum number of operations that need to be performed to transfer weights from one place to other on a container that weighs (limit)kg. A maximum of two weights can be combined together given their aggregate weight is less than or equal to limit. The heaviest weight is guaranteed to weigh less or equal to limit.
func minOperations(weights: [Int], limit: Int) -> Int {
    var sortedWeights = weights.sorted()
    var left = 0
    var right = sortedWeights.count - 1
    var operations = 0

    while left <= right {
        if sortedWeights[left] + sortedWeights[right] <= limit {
            left += 1
        }
        right -= 1
        operations += 1
    }

    return operations
}
