//
//  QueueRingBuffer.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 26.08.22.
//

struct QueueRingBuffer<T>: Queue {
    private var ringBuffer: RingBuffer<T>
    
    init(count: Int) {
        ringBuffer = RingBuffer<T>(count: count)
    }
    
    var isEmpty: Bool {
        ringBuffer.isEmpty
    }
    
    var peek: T? {
        ringBuffer.first
    }
    
    mutating func enqueue(_ element: T) -> Bool {
        ringBuffer.write(element)
    }
    
    mutating func dequeue() -> T? {
        ringBuffer.read()
    }
}
