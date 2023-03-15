//
//  RobotCleaner.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 15.03.23.
//

import Foundation

class Robot {
    func move() -> Bool { return true }
    
    func turnLeft() {}
    func turnRight() {}
    
    func clean() {}
}

struct Pair: Hashable {
    let x: Int
    let y: Int
    
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}

class RobotCleaner {
    let directions = [Pair(-1, 0), Pair(0, 1), Pair(1, 0), Pair(0, -1)]
    var visited = Set<Pair>()
    
    var robot = Robot()
    
    func goBack() {
        robot.turnRight()
        robot.turnRight()
        robot.move()
        robot.turnRight()
        robot.turnRight()
    }
    
    func backtrack(row: Int, column: Int, direction: Int) {
        visited.insert(Pair(row, column))
        robot.clean()
        
        ///0: UP
        ///1: RIGHT
        ///2: DOWN
        ///3: LEFT
        for i in 0...3 {
            let newDirection = (direction + i) % 4
            let newRow = row + directions[newDirection].x
            let newColumn = column + directions[newDirection].y
            
            if (!visited.contains(Pair(newRow, newColumn)) && robot.move()) {
                backtrack(row: newRow, column: newColumn, direction: newDirection)
                goBack()
            }
            
            robot.turnRight()
        }
    }
    
    func cleanRoom(_ robot: Robot) {
        self.robot = robot
        backtrack(row: 0, column: 0, direction: 0)
    }
    
}
