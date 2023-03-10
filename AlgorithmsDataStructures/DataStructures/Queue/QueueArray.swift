//
//  QueueArray.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 24.08.22.
//

struct QueueArray<T>: Queue {
    private var array: [T] = []
    init () {}
    
    ///O(1)
    var isEmpty: Bool {
        array.isEmpty
    }
    
    ///O(1)
    var peek: T? {
        array.first
    }
    
    ///O(1) or O(n) if copy of array is done behind scenes to allocate space if array runs out of memory space. This happens rarely
    mutating func enqueue(_ element: T) -> Bool {
        array.append(element)
        return true
    }
    
    ///O(n)
    mutating func dequeue() -> T? {
        isEmpty ? nil : array.removeFirst()
    }
}

extension QueueArray: CustomStringConvertible {
    public var description: String {
        String(describing: array)
    }
}
