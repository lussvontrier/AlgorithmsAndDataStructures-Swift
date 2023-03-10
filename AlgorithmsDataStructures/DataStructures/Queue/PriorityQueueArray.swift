//
//  PriorityQueueArray.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 15.10.22.
//

struct PriorityQueueArray<Element: Equatable>: Queue {
    
    private var array: [Element]
    private var sort: (Element, Element) -> Bool
    
    init(sort: @escaping (Element, Element) -> Bool, elements: [Element] = []) {
        self.array = elements
        self.sort = sort
        array.sort(by: sort)
    }
    
    var isEmpty: Bool {
        array.isEmpty
    }
    
    var peek: Element? {
        array.first
    }
    
    mutating func enqueue(_ element: Element) -> Bool {
        for (index, existingElement) in array.enumerated() {
            ///Checking if the element has a higher priority than existingElement
            if sort(element, existingElement) {
                array.insert(element, at: index)
                return true
            }
        }
        array.append(element)
        return true
    }
    
    mutating func dequeue() -> Element? {
        isEmpty ? nil : array.removeFirst()
    }
}

extension PriorityQueueArray: CustomStringConvertible {
    var description: String {
        String(describing: array)
    }
}
