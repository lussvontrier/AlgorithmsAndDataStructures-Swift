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
    
    func longestPalindrome(_ string: [Character]) -> String {
        if string.isEmpty { return "" }

        var start = 0, maxLength = 1 // Defaults for the case where each character can be a palindrome
        
        func expandAroundCenter(left: Int, right: Int) {
            var L = left, R = right
            while L >= 0 && R < string.count && string[L] == string[R] {
                let currentLength = R - L + 1
                if currentLength > maxLength {
                    maxLength = currentLength
                    start = L
                }
                L -= 1
                R += 1
            }
        }
        
        for i in 0..<string.count {
            // Expand around the single character (odd-length palindromes)
            expandAroundCenter(left: i, right: i)
            
            // Expand around the pair of consecutive characters (even-length palindromes)
            if i < string.count - 1 {
                expandAroundCenter(left: i, right: i + 1)
            }
        }
        
        return String(string[start..<start + maxLength])
    }
    
    func countOfPalindromes(for string: [Character]) -> Int {
        let n = string.count
        var count = 0

        // Function to expand around potential centers
        func expandAroundCenter(left: Int, right: Int) {
            var l = left
            var r = right
            while l >= 0 && r < n && string[l] == string[r] {
                count += 1
                l -= 1
                r += 1
            }
        }
        
        for i in 0..<n {
            // Count odd-length palindromes (single character centers)
            expandAroundCenter(left: i, right: i)
            
            // Count even-length palindromes (between characters centers)
            if i < n - 1 {
                expandAroundCenter(left: i, right: i + 1)
            }
        }
        return count
    }
}


