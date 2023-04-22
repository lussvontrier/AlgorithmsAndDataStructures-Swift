//
//  KnightMoves.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 17.04.23.
//

import Foundation

struct Square: Equatable, Hashable {
    var row: Int
    var column: Int

    func isValid() -> Bool {
        if row < 0 || column < 0 || row > 7 || column > 7 {
            return false
        } else {
            return true
        }
    }
}

struct KnightMove {
    let moveRow: Int
    let moveColumn: Int
}

class Knight {
    private let knightMoves = [KnightMove(moveRow: -1, moveColumn: -2),
                           KnightMove(moveRow: -2, moveColumn: -1),
                           KnightMove(moveRow: -2, moveColumn: 1),
                           KnightMove(moveRow: -1, moveColumn: 2),
                           KnightMove(moveRow: 1, moveColumn: 2),
                           KnightMove(moveRow: 2, moveColumn: 1),
                           KnightMove(moveRow: 2, moveColumn: -1),
                           KnightMove(moveRow: 1, moveColumn: -2)]
    
    ///Some memoization
    private var traversedSquaresDict: [Square: [Square]] = [:]

    func traverseKnight(startingFrom square: Square) {
        
        if let traversedSquares = traversedSquaresDict[square] {
            print(traversedSquares)
            
        } else if square.isValid() {
            var traversedSquares: [Square] = [square]

            if canTraverse(from: square, traversed: &traversedSquares) {
                traversedSquaresDict[square] = traversedSquares
                print(traversedSquares)
            } else {
                print("Can't traverse through all squares once from this starting point. Please choose another.")
            }
        } else {
            print("Invalid starting point. Please choose another.")
        }
    }

    private func canTraverse(from square: Square, traversed: inout [Square]) -> Bool {
        ///Base
        if traversed.count == 64 {
            return true
        }

        let possibleMoves = knightMoves.filter {
            let newSquare = apply(move: $0, to: square)
            return newSquare.isValid() && !traversed.contains(newSquare)
        }

        if possibleMoves.isEmpty {
            return false
        }

        let sortedMoves = possibleMoves.sorted {
            let newSquare1 = apply(move: $0, to: square)
            let newSquare2 = apply(move: $1, to: square)
            return accessibilityScore(for: newSquare1) < accessibilityScore(for: newSquare2)
        }

        for move in sortedMoves {
            let newSquare = apply(move: move, to: square)
            traversed.append(newSquare)

            if canTraverse(from: newSquare, traversed: &traversed) {
                return true
            } else {
                ///Backtrack
                traversed.removeLast()
            }
        }

        return false
    }
    
    ///Move the knight
    private func apply(move: KnightMove, to square: Square) -> Square {
        return Square(row: square.row + move.moveRow, column: square.column + move.moveColumn)
    }
    
    ///Warnsdorff’s rule
    private func accessibilityScore(for square: Square) -> Int {
        var count = 0
        for move in knightMoves {
            let newSquare = apply(move: move, to: square)
            if newSquare.isValid() {
                count += 1
            }
        }
        return count
    }
}

