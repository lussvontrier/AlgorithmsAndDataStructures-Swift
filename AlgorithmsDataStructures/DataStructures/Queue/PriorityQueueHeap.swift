//
//  PriorityQueueHeap.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 12.10.22.
//

struct PriorityQueueHeap<Element: Equatable>: Queue {
    
    private var heap: Heap<Element>
    
    init(sort: @escaping (Element, Element) -> Bool, elements: [Element] = []) {
        heap = Heap(sort: sort, elements: elements)
    }
    
    var isEmpty: Bool {
        heap.isEmpty
    }
    
    var peek: Element? {
        heap.peek()
    }
    
    mutating func enqueue(_ element: Element) -> Bool {
        heap.insert(element)
        return true
    }
    
    mutating func dequeue() -> Element? {
        heap.remove()
    }
}
