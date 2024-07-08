//
//  MaximumBuckets.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 08.07.24.
//

import Foundation

struct HoneySource {
    let name: String
    let time: Int
    let buckets: Int
}

class MaximumBuckets {
    func findMaximumBuckets(honeySources: [HoneySource], forAvailableTime availableTime: Int) -> (honeySources: [HoneySource], maximumBuckets: Int) {
        // Number of honey sources
        let countOfSources = honeySources.count
        
        // Create a 2D list to store the maximum buckets of honey for each subproblem
        // dp[i][j] represents the maximum buckets of honey using the first i honey sources with total time j
        var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: availableTime+1), count: countOfSources+1)
        
        // Create a 2D list to store the selected items for each subproblem
        // selected_items[i][j] stores the list of honey sources used to achieve dp[i][j]
        var selectedHoneySources: [[[HoneySource]]] = Array(repeating: Array(repeating: [], count: availableTime+1), count: countOfSources+1)
        
        for i in 1...countOfSources {
            for j in 1...availableTime {
                let currentAvailableTime = j
                let currentHoneySource = honeySources[i]
                let currentHoneySourceTime = currentHoneySource.time
                let currentHoneySourceBuckets = currentHoneySource.buckets
                
                // If the current honey source can fit into the current available time
                if currentHoneySourceTime <= currentAvailableTime {
                    let includeCurrent = dp[i-1][currentAvailableTime-currentHoneySourceTime] + currentHoneySourceBuckets
                    let excludeCurrent = dp[i-1][currentAvailableTime]
                    
                    if includeCurrent > excludeCurrent {
                        dp[i][currentAvailableTime] = includeCurrent
                        selectedHoneySources[i][currentAvailableTime] = selectedHoneySources[i-1][currentAvailableTime-currentHoneySourceTime] + [currentHoneySource]
                    } else {
                        dp[i][currentAvailableTime] = excludeCurrent
                        selectedHoneySources[i][currentAvailableTime] = selectedHoneySources[i-1][currentAvailableTime]
                    }
                } else {
                    // If the current honey source cannot fit, just carry forward the value from the previous row
                    dp[i][currentAvailableTime] = dp[i-1][currentAvailableTime]
                    selectedHoneySources[i][currentAvailableTime] = selectedHoneySources[i-1][currentAvailableTime]
                }
            }
        }
        
        let maxBucketsOfHoney = dp[countOfSources][availableTime]
        let honeySources = selectedHoneySources[countOfSources][availableTime]
        
        return (honeySources: honeySources, maximumBuckets: maxBucketsOfHoney)
    }
}
