//
//  BoardGameManager.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 26.08.22.
//

public protocol BoardGameManager {
    associatedtype Player
    mutating func nextPlayer() -> Player?
}

extension QueueArray: BoardGameManager {
    typealias Player = T
    
    mutating func nextPlayer() -> T? {
        guard let person = dequeue() else { return nil }
        enqueue(person)
        return person
    }
}


