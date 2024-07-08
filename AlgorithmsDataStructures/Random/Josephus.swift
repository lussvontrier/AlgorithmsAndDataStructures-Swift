//
//  Josephus.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 08.07.24.
//

import Foundation

class Josephus {
    /**
     After the first kill at `startIndex + k`, the next member will hold the sword (become starter).
     It will move `k` indexes to the left (<-). Every other member will also move `k` indexes to the left.
     The formula to find the new index for every item will be:
     
      **NewIndex = (CurrentIndex - k + n) % n**
     
     We subtract `k` but also add `n` to account for negative numbers then modulo `n` to account for circularity.
     If we know the `NewIndex` and want to get the `CurrentIndex` back, the formula will be:
     
      **CurrentIndex = (NewIndex + k) % n**
     
     Basically, the Josephus Formula will be:
     
      **J(n, k) = (J(n-1, k) + k) % n**
     
     After the kill, we need the safe index (position) of the survivor for `n-1` members and
     add `k` back to it to get the `CurrentIndex`.
     
     Example:
     n = 5, k = 3
     After every kill, the member after the killed moves to the first position at index 0.
     [0, 1, 2, 3, 4] index of 3 is 3
     [3, 4, 0, 1] index of 3 is 0
     [1, 3, 4] index of 3 is 1
     [1, 3] index of 3 is 1
     [3] index of 3 is 0
    **/
    
    /// **O(n) Recursive**
    func findIndexRecursive(members: [Int], shifts: Int) -> Int? {
        let membersCount = members.count
        if membersCount == 0 {
            return nil
        } else if membersCount == 1 {
            return 0
        } else {
            return findIndexRecursive(membersCount: membersCount, shifts: shifts)
        }
    }
    
    private func findIndexRecursive(membersCount: Int, shifts: Int) -> Int {
        if membersCount == 1 {
            return 0
        }
        return (findIndexRecursive(membersCount: membersCount-1, shifts: shifts) + shifts) % membersCount
    }
    
    /// **O(n) Iterative**
    func findIndexIterative(members: [Int], shifts: Int) -> Int? {
        let membersCount = members.count
        if membersCount == 0 {
            return nil
        } else if membersCount == 1 {
            return 0
        }
        
        var position = 0
        for i in 1...membersCount {
            position = (position + shifts) % i
        }
        return position
    }
    
    /// **O(n^2) Iterative**
    func indexIterative(members: [Int], shifts: Int) -> Int? {
        let membersCount = members.count
        if membersCount == 0 {
            return nil
        } else if membersCount == 1 {
            return 0
        }
        var members = members
        var indexToRemove = 0
        while members.count > 1 {
            indexToRemove = (indexToRemove + shifts - 1) % members.count
            members.remove(at: indexToRemove)
        }
        return members[0]
    }
    
    /// **O(n^2) Recursive**
    func indexRecursive(members: [Int], shifts: Int, start: Int) -> Int {
        if members.count == 1 {
            return members[0]
        }
        var indexToRemove = (start + shifts - 1) % members.count
        var newMembers = members
        newMembers.remove(at: indexToRemove)
        return indexRecursive(members: newMembers, shifts: shifts, start: indexToRemove)
    }
}
