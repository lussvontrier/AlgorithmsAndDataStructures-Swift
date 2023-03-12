//
//  NQueens.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 12.03.23.
//

import Foundation

class NQueens {
    private var count: Int = 0
    func totalNQueens(_ n: Int) -> Int {
        self.count = n
        var diagonals = Set<Int>()
        var antidiagonals = Set<Int>()
        var columns = Set<Int>()
        return backtrack(row: 0, diagonals: &diagonals, antidiagonals: &antidiagonals, columns: &columns)
    }
    
    private func backtrack(row: Int, diagonals: inout Set<Int>, antidiagonals: inout Set<Int>, columns: inout Set<Int>) -> Int {
        ///Base case: N queens have been placed
        if row == self.count { return 1 }
        
        var solutions = 0
        
        for column in 0..<self.count {
            let currentDiagonal = row - column
            let currentAntidiagonal = row + column
            
            ///If the queen is not placeable
            if columns.contains(column) || diagonals.contains(currentDiagonal) || antidiagonals.contains(currentAntidiagonal) {
                continue
            }
            
            ///Add the queen to the board
            columns.insert(column)
            diagonals.insert(currentDiagonal)
            antidiagonals.insert(currentAntidiagonal)
            
            /// Move on to the next row with the updated board state
            solutions += backtrack(row: row + 1, diagonals: &diagonals, antidiagonals: &antidiagonals, columns: &columns)
            
            /// "Remove" the queen from the board since we have already explored all valid paths using the above function call
            columns.remove(column)
            diagonals.remove(currentDiagonal)
            antidiagonals.remove(currentAntidiagonal)
        }
        return solutions
    }
}
