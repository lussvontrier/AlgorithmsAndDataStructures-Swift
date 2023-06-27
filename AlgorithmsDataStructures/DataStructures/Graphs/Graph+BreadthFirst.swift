//
//  Graph+BreadthFirst.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 08.06.23.
//

import Foundation

//MARK: Breadth-First Iterative
extension Graph where Element: Hashable {
    func breadthFirstIterative(from source: Vertex<Element>) -> [Vertex<Element>] {
        var queue = QueueStack<Vertex<Element>>()
        var enqueued: Set<Vertex<Element>> = []
        var visited: [Vertex<Element>] = []
        
        queue.enqueue(source)
        enqueued.insert(source)
        
        while let vertex = queue.dequeue() {
            visited.append(vertex)
            edges(from: vertex).forEach { edge in
                if !enqueued.contains(edge.destination) {
                    queue.enqueue(edge.destination)
                    enqueued.insert(edge.destination)
                }
            }
        }
        
        return visited
    }
}

//MARK: Breadth-First Recursive
extension Graph where Element: Hashable {
    func breadthFirstRecursive(from source: Vertex<Element>) -> [Vertex<Element>] {
        var queue = QueueStack<Vertex<Element>>()
        var enqueued: Set<Vertex<Element>> = []
        var visited: [Vertex<Element>] = []
        
        queue.enqueue(source)
        enqueued.insert(source)
        
        bfs(queue: &queue, enqueued: &enqueued, visited: &visited)
        
        return visited
    }
    
    private func bfs(queue: inout QueueStack<Vertex<Element>>, enqueued: inout Set<Vertex<Element>>, visited: inout [Vertex<Element>]) {
        
        guard let vertex = queue.dequeue() else { return }
        
        visited.append(vertex)
        
        edges(from: vertex).forEach { edge in
            if !enqueued.contains(edge.destination) {
                enqueued.insert(edge.destination)
                queue.enqueue(edge.destination)
            }
        }
        
        bfs(queue: &queue, enqueued: &enqueued, visited: &visited)
    }
}
