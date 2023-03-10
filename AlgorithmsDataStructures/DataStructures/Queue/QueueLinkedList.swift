//
//  QueueLinkedList.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 24.08.22.
//

class QueueLinkedList<T>: Queue {
    private var list = DoublyLinkedList<T>()
    init() {}
    
    var isEmpty: Bool {
        return list.isEmpty
    }
    
    var peek: T? {
        return list.first?.value
    }
    
    func enqueue(_ element: T) -> Bool {
        list.append(element)
        return true
    }
    
    func dequeue() -> T? {
        guard !list.isEmpty, let element = list.first else {
            return nil
        }
        return list.remove(element)
    }
    
}
