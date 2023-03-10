//
//  QueueStack.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 26.08.22.
//

struct QueueStack<T>: Queue {
    private var dequeueStack: [T] = []
    private var enqueueStack: [T] = []

    init() {}
    
    var isEmpty: Bool {
        dequeueStack.isEmpty && enqueueStack.isEmpty
    }
    
    var peek: T? {
        !dequeueStack.isEmpty ? dequeueStack.last : enqueueStack.first
    }
    
    ///O(1) usually except when array needs to copy to allocate for more space
    mutating func enqueue(_ element: T) -> Bool {
        enqueueStack.append(element)
        return true
    }
    
    ///Reversing an array is O(n) but dequeue will be amortized O(1) as reversed() will be called only when dequeueStack isEmpty
    mutating func dequeue() -> T? {
        if dequeueStack.isEmpty {
            dequeueStack = enqueueStack.reversed()
            enqueueStack.removeAll()
        }
        return dequeueStack.popLast()
    }
}
