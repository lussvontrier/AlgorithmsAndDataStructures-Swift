//
//  AdjacencyListGraph.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 01.06.23.
//

import Foundation

class AdjacencyListGraph<T: Hashable>: Graph {
    private var adjacencies: [Vertex<T>: [Edge<T>]] = [:]
    
    init() {}
    
    //MARK: Return All Vertices
    var allVertices: [Vertex<T>] {
        Array(adjacencies.keys)
    }
    
    //MARK: Create Vertex
    func createVertex(data: T) -> Vertex<T> {
        let vertex = Vertex(index: adjacencies.count, data: data)
        adjacencies[vertex] = []
        return vertex
    }
    
    //MARK: Add Directed Edge
    func addDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
        let edge = Edge(source: source, destination: destination, weight: weight)
        adjacencies[source]?.append(edge)
    }
    
    //MARK: Retrieve Edges
    func edges(from source: Vertex<T>) -> [Edge<T>] {
        adjacencies[source] ?? []
    }
    
    //MARK: Retrieve Weight
    func weight(from source: Vertex<T>, to destination: Vertex<T>) -> Double? {
        edges(from: source).first { $0.destination == destination }?.weight
    }
}

extension AdjacencyListGraph: CustomStringConvertible {
    var description: String {
        var result = ""
        
        for (vertex, edges) in adjacencies {
            var edgeString = ""
            
            for (index, edge) in edges.enumerated() {
                if index != edges.count - 1 {
                    edgeString.append("\(edge.destination), ")
                } else {
                    edgeString.append("\(edge.destination)")
                }
            }
            result.append("\(vertex) ---> [ \(edgeString) ]\n")
        }
        return result
    }
}
