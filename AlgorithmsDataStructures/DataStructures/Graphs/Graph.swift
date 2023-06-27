//
//  Graph.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 01.06.23.
//

import Foundation

enum EdgeType {
    case directed
    case undirected
}

protocol Graph {
    associatedtype Element
    
    var allVertices: [Vertex<Element>] { get }
    func createVertex(data: Element) -> Vertex<Element>
    func addDirectedEdge(from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?)
    func addUndirectedEdge(between source: Vertex<Element>, and destination: Vertex<Element>, weight: Double?)
    func add(_ edge: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?)
    func edges(from source: Vertex<Element>) -> [Edge<Element>]
    func weight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double?
}

extension Graph {
    func addUndirectedEdge(between source: Vertex<Element>, and destination: Vertex<Element>, weight: Double?) {
        addDirectedEdge(from: source, to: destination, weight: weight)
        addDirectedEdge(from: destination, to: source, weight: weight)
    }
    
    func add(_ edge: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) {
        switch edge {
        case .directed:
            addDirectedEdge(from: source, to: destination, weight: weight)
        case .undirected:
            addUndirectedEdge(between: source, and: destination, weight: weight)
        }
    }
}

//MARK: isDisconnected
extension Graph where Element: Hashable {
    func isDisconnected() -> Bool {
        guard let firstVertex = allVertices.first else { return false }
        
        let visited = breadthFirstIterative(from: firstVertex)
        
        for vertex in allVertices {
            if !visited.contains(vertex) {
                return true
            }
        }
        return false
    }
}

//MARK: hasCycle
extension Graph where Element: Hashable {
    func hasCycle(from source: Vertex<Element>) -> Bool {
        var pushed: Set<Vertex<Element>> = []
        return hasCycle(from: source, pushed: &pushed)
    }
    
    private func hasCycle(from source: Vertex<Element>, pushed: inout Set<Vertex<Element>>) -> Bool {
        pushed.insert(source)
        
        let neighbors = edges(from: source)
        for edge in neighbors {
            if !pushed.contains(edge.destination) && hasCycle(from: edge.destination) {
                return true
            } else if pushed.contains(edge.destination) {
                return true
            }
        }
        pushed.remove(source)
        return false
    }
}


