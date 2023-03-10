//
//  ReverseQueue.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 26.08.22.
//

extension QueueArray {
    func reversed() -> QueueArray {
        var queue = self
        var stack = Stack<T>()
        
        while let element = queue.dequeue() {
            stack.push(element)
        }
        
        while let element = stack.pop() {
            queue.enqueue(element)
        }
        return queue
    }
}


