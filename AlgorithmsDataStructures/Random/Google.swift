//
//  Google.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 25.07.23.
//

import Foundation

class Google {
    //MARK: Valid Tournament, Complexity: O(nlogn)
    private func isValidRound(players: [Int]) -> Bool {
        let count = players.count
        for i in stride(from: 0, to: count-2, by: 2) {
            if players[i] + players[i+1] != count+1 {
                return false
            }
        }
        return true
    }

    func isValidTournament(players: [Int]) -> Bool {
        if players.count <= 2 {
            return true
        }
        if isValidRound(players: players) {
            var nextRoundPlayers: [Int] = []
            for i in stride(from: 0, to: players.count-1, by: 2) {
                nextRoundPlayers.append(min(players[i], players[i+1]))
            }
            return isValidTournament(players: nextRoundPlayers)
        } else {
            return false
        }
    }
    
    //MARK: BFS with parallelization, nearest destination node from a number of start nodes, edge weight is 1
    func nearestDestinationVertex(startingVertices: [Int], destinationVertices: [Int], edges: [[Int]]) -> Int? {
        // Create an adjacency list representation of the graph.
        var graph = [Int: [Int]]()
        for edge in edges {
            graph[edge[0], default: []].append(edge[1])
            graph[edge[1], default: []].append(edge[0])
        }
        
        // Helper function to perform BFS from a given starting vertex.
        func bfs(_ start: Int) -> [Int: Int] {
            var distances = [Int: Int]() // Dictionary to store the shortest distances from start to all other vertices
            var queue = [(vertex: start, distance: 0)] // Tuple for BFS
            var visited = Set<Int>()
            visited.insert(start)
            
            while !queue.isEmpty {
                let (vertex, distance) = queue.removeFirst()
                distances[vertex] = distance
                
                for neighbor in graph[vertex] ?? [] {
                    if !visited.contains(neighbor) {
                        visited.insert(neighbor)
                        queue.append((neighbor, distance + 1))
                    }
                }
            }
            
            return distances
        }
        
        var minMaxDistance = Int.max
        var minMaxVertex: Int? = nil

        // Perform BFS from each starting vertex.
        for start in startingVertices {
            let distances = bfs(start)

            // Find the maximum distance from this starting vertex to any destination vertex.
            var maxDistance = Int.min
            for dest in destinationVertices {
                if let dist = distances[dest] {
                    maxDistance = max(maxDistance, dist)
                } else {
                    // If any destination vertex is not reachable from this starting vertex, skip it.
                    maxDistance = Int.max
                    break
                }
            }

            // Update the minimum maximum distance and corresponding destination vertex.
            if maxDistance < minMaxDistance {
                minMaxDistance = maxDistance
                minMaxVertex = start
            }
        }

        // If no destination vertex is reachable by all starting vertices, return nil.
        if minMaxVertex == nil {
            return nil
        }
        
        // Otherwise, return the corresponding destination vertex with the minimum maximum distance.
        return minMaxVertex
    }
    // [1, 2, 5]
    func reachables(startVertices: [Int], endVertices: [Int], edges: [[Int]]) -> Int? {
        var graph: [Int: [Int]] = [:]
        for edge in edges {
            let v1 = edge[0]
            let v2 = edge[1]
            graph[v1, default: []].append(v2)
            graph[v2, default: []].append(v1)
        }
        
        var queue: [(parent: Int, current: Int, vertexLevel: Int)] = startVertices.map { ($0, $0, 0) }
        
        var visited: [Int: Set<Int>] = [:]
        //Count of each end vertex that has been visited, if it is equal to start.count, return that end vertex
        var countOfEndsVisited: [Int: Int] = [:]
        var currentLevel = -1
        var isNewLevel = false
        while !queue.isEmpty {
            let (currentParent, currentVertex, vertexLevel) = queue.removeFirst()
            
            if endVertices.contains(currentVertex) {
                countOfEndsVisited[currentVertex, default: 0] += 1
            }
            
            if vertexLevel > currentLevel {
                currentLevel = vertexLevel
                isNewLevel = true
            }

            visited[currentParent, default: []].insert(currentVertex)
            
            if let neighbors = graph[currentVertex] {
                for neighbor in neighbors {
                    if !visited[currentParent, default: []].contains(neighbor) {
                        queue.append((parent: currentParent, current: neighbor, vertexLevel: vertexLevel+1))
                    }
                }
            }
            
            if isNewLevel || queue.isEmpty {
                if countOfEndsVisited[currentVertex] == startVertices.count {
                    return currentVertex
                }
            }
        }
        
        return nil
    }

}
