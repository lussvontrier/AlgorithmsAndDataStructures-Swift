//
//  Vertex.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 01.06.23.
//

import Foundation

struct Vertex<T> {
    let index: Int
    let data: T
}

extension Vertex: Hashable where T: Hashable {}
extension Vertex: Equatable where T: Equatable {}

extension Vertex: CustomStringConvertible {
    var description: String {
        "\(index): \(data)"
    }
}
