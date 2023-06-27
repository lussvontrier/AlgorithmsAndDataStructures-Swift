//
//  Edge.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 01.06.23.
//

import Foundation

struct Edge<T> {
    let source: Vertex<T>
    let destination: Vertex<T>
    let weight: Double?
}
