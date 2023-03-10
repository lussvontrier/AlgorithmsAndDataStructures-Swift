//
//  TrieNode.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 22.09.22.
//

class TrieNode<Key: Hashable> {
    var key: Key?
    weak var parent: TrieNode?
    var children: [Key: TrieNode] = [:]
    var isTerminating = false
    
    init(key: Key?, parent: TrieNode?) {
        self.key = key
        self.parent = parent
    }
}
