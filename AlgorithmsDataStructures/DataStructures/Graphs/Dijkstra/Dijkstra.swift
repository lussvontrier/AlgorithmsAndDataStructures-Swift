//
//  Dijkstra.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 03.07.23.
//

import Foundation

enum Visit<T: Hashable> {
    case start
    case edge(Edge<T>)
}

class Dijkstra<T: Hashable> {
    let graph: AdjacencyListGraph<T>
    
    init(graph: AdjacencyListGraph<T>) {
        self.graph = graph
    }
    
    func shortestPath(from start: Vertex<T>) -> [Vertex<T>: Visit<T>] {
        var paths: [Vertex<T>: Visit<T>] = [start: .start]
        
        var priorityQueue = PriorityQueueArray<Vertex<T>> {
            self.distance(to: $0, with: paths) < self.distance(to: $1, with: paths)
        }
        priorityQueue.enqueue(start)
        
        while let vertex = priorityQueue.dequeue() {
            for edge in graph.edges(from: vertex) {
                guard let weight = edge.weight else { continue }
                
                if paths[edge.destination] == nil || distance(to: vertex, with: paths) + weight < distance(to: edge.destination, with: paths) {
                    paths[edge.destination] = .edge(edge)
                    priorityQueue.enqueue(edge.destination)
                }
            }
        }
        return paths
    }
    
    func shortestPath(to destination: Vertex<T>, paths: [Vertex<T>: Visit<T>]) -> [Edge<T>] {
        return route(to: destination, with: paths)
    }
    
    func getAllShortestPath(from source: Vertex<T>) -> [Vertex<T>: [Edge<T>]] {
        var pathsDict = [Vertex<T>: [Edge<T>]]()
        let pathsFromSource = shortestPath(from: source)
        for vertex in graph.allVertices {
            let shortestPath = shortestPath(to: vertex, paths: pathsFromSource)
            pathsDict[vertex] = shortestPath
        }
        return pathsDict
    }
    
    private func route(to destination: Vertex<T>, with paths: [Vertex<T>: Visit<T>]) -> [Edge<T>] {
        var vertex = destination
        var path: [Edge<T>] = []
        
        while let visit = paths[vertex], case .edge(let edge) = visit {
            path = [edge] + path
            vertex = edge.source
        }
        return path
    }
    
    private func distance(to destination: Vertex<T>, with paths: [Vertex<T>: Visit<T>]) -> Double {
        let path = route(to: destination, with: paths)
        let distances = path.compactMap { $0.weight }
        return distances.reduce(0.0, +)
    }
    
}
