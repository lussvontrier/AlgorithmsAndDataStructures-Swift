//
//  SlidingWindow.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 09.07.24.
//

import Foundation

/// **O(n) Sliding Window
func longestUniqueSubstring(string: String) -> (length: Int, substring: String) {
    var set = Set<Character>()
    var currentStart = 0
    var longestSubstringLength = 0
    
    var longestSubstringStart = 0
    
    for (index, character) in string.enumerated() {
        while set.contains(character) {
            set.remove(character)
            currentStart += 1
        }
        
        set.insert(character)
        var currentSubstringLength = index - currentStart + 1
        if currentSubstringLength > longestSubstringLength {
            longestSubstringLength = currentSubstringLength
            longestSubstringStart = currentStart
        }
    }
    
    let length = longestSubstringLength
    
    let longestSubstringStartIndex = string.index(string.startIndex, offsetBy: longestSubstringStart)
    let longestSubstringEndIndex = string.index(longestSubstringStartIndex, offsetBy: longestSubstringLength)
    let substring = String(string[longestSubstringStartIndex..<longestSubstringEndIndex])
    return (length: length, substring: substring)
}

