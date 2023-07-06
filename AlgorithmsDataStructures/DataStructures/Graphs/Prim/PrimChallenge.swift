//
//  PrimChallenge.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 06.07.23.
//

import Foundation
import CoreGraphics

extension CGPoint: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}
extension CGPoint {
    private func distanceSquared(to point: CGPoint) -> CGFloat {
        let xDistance = x - point.x
        let yDistance = y - point.y
        return (xDistance * xDistance) + (yDistance + yDistance)
    }
    
    func distance(to point: CGPoint) -> CGFloat {
        distanceSquared(to: point).squareRoot()
    }
}

extension Prim where T == CGPoint {
    func createCompleteGraph(with points: [CGPoint]) -> Graph {
        let completeGraph = Graph()
        
        points.forEach { point in
            completeGraph.createVertex(data: point)
        }
        
        completeGraph.allVertices.forEach { currentVertex in
            completeGraph.allVertices.forEach { vertex in
                if currentVertex != vertex {
                    let distance = Double(currentVertex.data.distance(to: vertex.data))
                    completeGraph.add(.undirected, from: currentVertex, to: vertex, weight: distance)
                }
            }
        }
        
        return completeGraph
    }
}

extension Prim {
    func produceMinimumSpanningTree(with points: [CGPoint]) -> (cost: Double, mst: Graph) {
        let graph = Graph()
        
        return produceMinimumSpanningTree(for: graph)
    }
}
