//
//  Graph+DepthFirst.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 08.06.23.
//

import Foundation

//MARK: Depth-First
extension Graph where Element: Hashable {
    func depthFirstIterative(from source: Vertex<Element>) -> [Vertex<Element>] {
        var stack = Stack<Vertex<Element>>()
        var pushed: Set<Vertex<Element>> = []
        var visited: [Vertex<Element>] = []
        
        stack.push(source)
        pushed.insert(source)
        visited.append(source)
        
        outer: while let vertex = stack.peek() {
            let neighbors = edges(from: vertex)
            guard !neighbors.isEmpty else {
                stack.pop()
                continue
            }
            for edge in neighbors {
                if !pushed.contains(edge.destination) {
                    stack.push(edge.destination)
                    pushed.insert(edge.destination)
                    visited.append(edge.destination)
                    continue outer
                }
            }
            stack.pop()
        }
        
        return visited
    }
}

//MARK: Depth-First Recursive with Stack
extension Graph where Element: Hashable {
    func depthFirstRecursive1(from source: Vertex<Element>) -> [Vertex<Element>] {
        var stack = Stack<Vertex<Element>>()
        var pushed: Set<Vertex<Element>> = []
        var visited: [Vertex<Element>] = []
        
        stack.push(source)
        pushed.insert(source)
        
        dfs(stack: &stack, pushed: &pushed, visited: &visited)
        
        return visited
    }
    
    private func dfs(stack: inout Stack<Vertex<Element>>, pushed: inout Set<Vertex<Element>>, visited: inout [Vertex<Element>]) {
        
        guard let vertex = stack.peek() else { return }
        
        visited.append(vertex)
        
        let neighbors = edges(from: vertex)
        
        if neighbors.isEmpty {
            return
        } else {
            neighbors.forEach { edge in
                if !pushed.contains(edge.destination) {
                    stack.push(edge.destination)
                    pushed.insert(edge.destination)
                    
                    dfs(stack: &stack, pushed: &pushed, visited: &visited)
                }
                
            }
            stack.pop()
        }
    }
}

//MARK: Depth-First Recursive w/o Stack
extension Graph where Element: Hashable {
    func depthFirstRecursive2(from start: Vertex<Element>) -> [Vertex<Element>] {
        var visited: [Vertex<Element>] = []
        var pushed: Set<Vertex<Element>> = []
        depthFirstSearch(from: start,
                         visited: &visited,
                         pushed: &pushed)
        return visited
    }
    
    private func depthFirstSearch(from source: Vertex<Element>,
                          visited: inout [Vertex<Element>],
                          pushed: inout Set<Vertex<Element>>) {
        pushed.insert(source)
        visited.append(source)
        let neighbors = edges(from: source)
        for edge in neighbors {
            if !pushed.contains(edge.destination) {
                depthFirstSearch(from: edge.destination, 
                                 visited: &visited,
                                 pushed: &pushed)
            }
        }
    }
}
