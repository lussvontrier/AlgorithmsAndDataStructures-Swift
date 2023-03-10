//
//  Trie.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 22.09.22.
//

class Trie<CollectionType: Collection & Hashable> where CollectionType.Element: Hashable {
    typealias Node = TrieNode<CollectionType.Element>
    
    private let root = Node(key: nil, parent: nil)
    init() {}
    
    private(set) var collections: Set<CollectionType> = []
    
    var count: Int {
        collections.count
    }
    var isEmpty: Bool {
        collections.isEmpty
    }
    
    func insert(_ collection: CollectionType) {
        var current = root
        for element in collection {
            if current.children[element] == nil {
                current.children[element] = Node(key: element, parent:
                                                    current)
            }
            current = current.children[element]!
        }
        if current.isTerminating {
            return
        } else {
            current.isTerminating = true
            collections.insert(collection)
        }
    }
    
    func contains(_ collection: CollectionType) -> Bool {
        var current = root
        for element in collection {
            guard let child = current.children[element] else {
                return false
            }
            current = child
        }
        return current.isTerminating
    }
    
    func remove(_ collection: CollectionType) {
        var current = root
        for element in collection {
            guard let child = current.children[element] else {
                ///Collection not found
                return
            }
            current = child
        }
        guard current.isTerminating else {
            ///Collection not found
            return
        }
        current.isTerminating = false
        collections.remove(collection)
        while let parent = current.parent, !current.isTerminating && current.children.isEmpty {
            parent.children[current.key!] = nil
            current = parent
        }
    }
}

extension Trie where CollectionType: RangeReplaceableCollection {
    func collections(startingWith prefix: CollectionType) -> [CollectionType] {
        var current = root
        for element in prefix {
            guard let child = current.children[element] else { return [] }
            current = child
        }
        return collections(startingWith: prefix, after: current)
    }
    
    private func collections(startingWith prefix: CollectionType, after node: Node) -> [CollectionType] {
        var results: [CollectionType] = []
        
        if node.isTerminating {
            results.append(prefix)
        }
        
        for child in node.children.values {
            var prefix = prefix
            prefix.append(child.key!)
            results.append(contentsOf: collections(startingWith: prefix, after: child))
        }
        
        return results
    }
}


