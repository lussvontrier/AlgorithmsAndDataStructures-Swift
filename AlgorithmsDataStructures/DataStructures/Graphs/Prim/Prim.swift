//
//  Prim.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 06.07.23.
//

import Foundation

class Prim<T: Hashable> {
    typealias Graph = AdjacencyListGraph<T>
    init() {}
    
    func produceMinimumSpanningTree(for graph: Graph) -> (cost: Double, mst: Graph) {
        var cost = 0.0
        let mst = Graph()
        var visited: Set<Vertex<T>> = []
        var priorityQueue = PriorityQueueArray<Edge<T>> {
            $0.weight ?? 0.0 < $1.weight ?? 0.0
        }
        
        mst.copyVertices(from: graph)
        guard let start = graph.allVertices.first else {
            return (cost: cost, mst: mst)
        }
        
        visited.insert(start)
        addAvailableEdges(for: start, in: graph, check: visited, to: &priorityQueue)
        
        while let smallestEdge = priorityQueue.dequeue() {
            let vertex = smallestEdge.destination
            guard !visited.contains(vertex) else {
                continue
            }
            
            visited.insert(vertex)
            cost += smallestEdge.weight ?? 0.0
            
            mst.add(.undirected, from: smallestEdge.source, to: smallestEdge.destination, weight: smallestEdge.weight)
            
            addAvailableEdges(for: vertex, in: graph, check: visited, to: &priorityQueue)
        }
        
        return (cost: cost, mst: mst)
    }
    
    func addAvailableEdges(for vertex: Vertex<T>, in graph: Graph, check visited: Set<Vertex<T>>, to priorityQueue: inout PriorityQueueArray<Edge<T>>) {
        for edge in graph.edges(from: vertex) {
            if !visited.contains(edge.destination) {
                priorityQueue.enqueue(edge)
            }
        }
    }
}
