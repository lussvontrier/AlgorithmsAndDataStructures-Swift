//
//  Queue.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 24.08.22.
//

protocol Queue {
    associatedtype Element
    mutating func enqueue(_ element: Element) -> Bool
    mutating func dequeue() -> Element?
    var isEmpty: Bool { get }
    var peek: Element? { get }
}
