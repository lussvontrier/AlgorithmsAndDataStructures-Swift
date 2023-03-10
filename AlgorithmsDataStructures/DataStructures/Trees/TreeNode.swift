//
//  TreeNode.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 31.08.22.
//

class TreeNode<T> {
    let value: T
    var children: [TreeNode] = []
    
    init(_ value: T) {
        self.value = value
    }
    
    func add(_ child: TreeNode) {
        children.append(child)
    }
}

//MARK: Depth-first traversal
extension TreeNode {
    func forEachDepthFirst(visit: (TreeNode) -> Void) {
        visit(self)
        children.forEach {
            $0.forEachDepthFirst(visit: visit)
        }
    }
}

//MARK: Level-order traversal
extension TreeNode {
    func forEachLevelOrder(visit: (TreeNode) -> Void) {
        visit(self)
        
        var queue = QueueArray<TreeNode>()
        children.forEach({ queue.enqueue($0) })
        
        while let treeNode = queue.dequeue() {
            visit(treeNode)
            treeNode.children.forEach({ queue.enqueue($0) })
        }
    }
}

//MARK: Search
extension TreeNode where T: Equatable {
    func search(_ value: T) -> TreeNode? {
        var result: TreeNode?
        
        forEachLevelOrder { node in
            if node.value == value {
                result = node
            }
        }
        
        return result
    }
}

