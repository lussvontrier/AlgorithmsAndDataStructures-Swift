//
//  SudokuSolver.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 18.03.23.
//

import Foundation

class SudokuSolver {
    internal typealias Char = Character
    func solveSudoku(_ board: inout [[Char]]) {
        guard board.count != 0 || board[0].count != 0 else { return } // Check if the board is not empty
        helper(&board) // Call the recursive helper function to solve the Sudoku
    }
    
    private func helper(_ board: inout [[Char]]) -> Bool {
        for r in 0..<board.count { // Traverse through each row
            for c in 0..<board[0].count where board[r][c] == "." { // Traverse through each column in the row, where there's an empty cell (denoted by ".")
                for n in 1...9 where isValid(board, Char("\(n)"), r, c) { // Try to fill the empty cell with numbers from 1 to 9 if the number is valid
                    board[r][c] = Char("\(n)") // Fill the empty cell with the number n
                    if helper(&board) { // If the board is solved after filling the current empty cell, return true
                        return true
                    } else { // Otherwise, backtrack and try a different number
                        board[r][c] = "."
                    }
                }
                return false // If no number can be filled in the current empty cell, return false and backtrack to the previous empty cell
            }
        }
        return true // If all cells are filled and valid, return true to indicate that the Sudoku is solved
    }
    
    // Helper function to check if the number can be filled in the given cell
    private func isValid(_ board: [[Char]], _ ch: Char, _ r: Int, _ c: Int) -> Bool {
        for i in 0...8 {
            if board[r][i] == ch || board[i][c] == ch { return false } // Check if the number already exists in the same row or column
            if board[(r / 3) * 3 + i / 3][(c / 3) * 3 + i % 3] == ch { return false } // Check if the number already exists in the 3x3 sub-box
        }
        return true // If the number is not found in the same row, column or sub-box, it can be filled in the given cell
    }
}
