//
//  Graph+Paths.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 08.06.23.
//

import Foundation

//MARK: Number of paths between vertices, directed graph
extension Graph where Element: Hashable {
    func numberOfPaths(from source: Vertex<Element>, to destination: Vertex<Element>) -> Int {
        var numberOfPaths = 0
        var visited: Set<Vertex<Element>> = []
        paths(from: source,
              to: destination,
              visited: &visited,
              pathCount: &numberOfPaths)
        return numberOfPaths
    }
    
    private func paths(from source: Vertex<Element>,
                       to destination: Vertex<Element>,
                       visited: inout Set<Vertex<Element>>,
                       pathCount: inout Int) {
        
        visited.insert(source)
        
        if source == destination {
            pathCount += 1
        } else {
            for edge in edges(from: source) {
                if !visited.contains(edge.destination) {
                    paths(from: edge.destination,
                          to: destination,
                          visited: &visited,
                          pathCount: &pathCount)
                }
            }
        }
        
        visited.remove(source)
    }
}

//MARK: Path exists between vertices
extension Graph where Element: Hashable {
    func pathExists(from source: Vertex<Element>, to destination: Vertex<Element>) -> Bool {
        var queue = QueueStack<Vertex<Element>>()
        var enqueued: Set<Vertex<Element>> = []
        
        queue.enqueue(source)
        enqueued.insert(source)
        
        while let vertex = queue.dequeue() {
            if vertex == destination {
                return true
            }
            edges(from: vertex).forEach { edge in
                if !enqueued.contains(edge.destination) {
                    queue.enqueue(edge.destination)
                    enqueued.insert(edge.destination)
                }
            }
        }
        return false
    }
}
