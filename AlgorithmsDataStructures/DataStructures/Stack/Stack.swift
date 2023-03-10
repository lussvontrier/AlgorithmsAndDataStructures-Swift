//
//  Stack.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 16.08.22.
//

import Foundation

struct Stack<Element> {
    private var storage: [Element] = []
    
    var isEmpty: Bool {
        peek() == nil
    }
    
    init() { }

    init(_ elements: [Element]) {
        storage = elements
    }
    
    //MARK: operations
    mutating func push(_ element: Element) {
        storage.append(element)
    }
    
    @discardableResult
    mutating func pop() -> Element? {
        storage.popLast()
    }
    
    func peek() -> Element? {
        storage.last
    }
}

extension Stack: CustomDebugStringConvertible {
    var debugDescription: String {
        return "\(storage.map({"\($0)"}).reversed().joined(separator: "\n"))"
    }
}

extension Stack: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        storage = elements
    }
}
