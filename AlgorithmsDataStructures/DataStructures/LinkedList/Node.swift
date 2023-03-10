//
//  Node.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 09.08.22.
//

class Node<T> {
    
    var value: T
    
    var next: Node?
    weak var previous: Node?
    
    init(value: T, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

extension Node: CustomStringConvertible {
//    var description: String {
//        guard let next = next else { return "\(value)" }
//        return "\(value) -> " + String(describing: next) + " "
//    }
    var description: String {
        return "\(value)"
    }
}
