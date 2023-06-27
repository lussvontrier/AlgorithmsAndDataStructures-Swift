//
//  AdjacencyMatrixGraph.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 02.06.23.
//

import Foundation

class AdjacencyMatrixGraph<T>: Graph {
    var vertices: [Vertex<T>] = []
    var weights: [[Double?]] = []
    
    init() {}
    
    //MARK: Return All Vertices
    var allVertices: [Vertex<T>] {
        vertices
    }
    
    //MARK: Create Vertex
    func createVertex(data: T) -> Vertex<T> {
        let vertex = Vertex(index: vertices.count, data: data)
        vertices.append(vertex)
        
        for i in 0..<weights.count {
            weights[i].append(nil)
        }
        
        let newRow = [Double?](repeating: nil, count: vertices.count)
        weights.append(newRow)
        
        return vertex
    }
    
    //MARK: Add Directed Edge
    func addDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
        weights[source.index][destination.index] = weight
    }
    
    //MARK: Retrieve Edges
    func edges(from source: Vertex<T>) -> [Edge<T>] {
        var edges = [Edge<T>]()
        
        for column in 0..<weights.count {
            if let weight = weights[source.index][column] {
                edges.append(Edge(source: source, destination: vertices[column], weight: weight))
            }
        }
        
        return edges
    }
    
    //MARK: Retrieve Weight
    func weight(from source: Vertex<T>, to destination: Vertex<T>) -> Double? {
        weights[source.index][destination.index]
    }
}

extension AdjacencyMatrixGraph: CustomStringConvertible {
    var description: String {
        let verticesDescription = vertices.map { "\($0)"}.joined(separator: "\n")
        
        var grid: [String] = []
        for i in 0..<weights.count {
            var row = ""
            for j in 0..<weights.count {
                if let value = weights[i][j] {
                    row += "\(value)\t"
                } else {
                    row += "ø\t\t"
                }
            }
            grid.append(row)
        }
        let edgesDescription = grid.joined(separator: "\n")
        
        return "\(verticesDescription)\n\n\(edgesDescription)"
    }
}
