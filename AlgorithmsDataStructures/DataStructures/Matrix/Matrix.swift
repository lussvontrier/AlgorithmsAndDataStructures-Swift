//
//  Matrix.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 08.03.23.
//

class Matrix {
    var matrix: [[Int]] = [[]]
    var target: Int = 0
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        self.matrix = matrix
        self.target = target
        
        if matrix.isEmpty || matrix[0].isEmpty { return false }
        
        return search(0, 0, matrix[0].count-1, matrix.count-1)
    }
    
    private func search(_ left: Int, _ top: Int, _ right: Int, _ bottom: Int) -> Bool {
        if left > right || top > bottom {
            return false
        } else if target < matrix[top][left] || target > matrix[bottom][right] {
            return false
        }
        
        let midColumn = left + (right - left)/2
        var currentRow = top
        while currentRow <= bottom && matrix[currentRow][midColumn] <= target {
            if matrix[currentRow][midColumn] == target {
                return true
            }
            currentRow += 1
        }
        
        return search(left, currentRow, midColumn - 1, bottom) || search(midColumn + 1, top, right, currentRow - 1)
    }
}
