//
//  Palindrome.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 04.11.22.
//

class Palindrome {
    static func longestPalindrome(for string: [Character]) -> [Character] {
        if string == string.reversed() {
            return string
        } else {
            let a = longestPalindrome(for: Array(string[0...string.count-2]))
            let b = longestPalindrome(for: Array(string[1...string.count-1]))
            return a.count > b.count ? a : b
        }
    }
}


