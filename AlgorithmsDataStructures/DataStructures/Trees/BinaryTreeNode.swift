//
//  BinaryTreeNode.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 31.08.22.
//

import Metal

final class BinaryTreeNode<T> {
    var value: T
    var leftChild: BinaryTreeNode?
    var rightChild: BinaryTreeNode?
    
    var height = 0
    
    var balanceFactor: Int {
        leftHeight - rightHeight
    }
    var leftHeight: Int {
        leftChild?.height ?? -1
    }
    var rightHeight: Int {
        rightChild?.height ?? -1
    }
    
    init(value: T) {
        self.value = value
    }
    
    var min: BinaryTreeNode {
        return leftChild?.min ?? self
    }
}

extension BinaryTreeNode: TraversableBinaryNode {}

//MARK: Check if the binary tree is a binary search tree
extension BinaryTreeNode where T: Comparable {
    var isBST: Bool {
        isBST(self, min: nil, max: nil)
    }
    
    private func isBST(_ tree: BinaryTreeNode<T>?, min: T?, max: T?) -> Bool {
        guard let tree = tree else { return true }
        
        if let min = min, tree.value <= min {
            return false
        } else if let max = max, tree.value > max {
            return false
        }
        
        return isBST(tree.leftChild, min: min, max: tree.value) &&
               isBST(tree.rightChild, min: tree.value, max: max)
    }
}

//MARK: Height
extension BinaryTreeNode {
    static func height(of node: BinaryTreeNode<T>?) -> Int {
        guard let node = node else {
            return -1
        }
        return 1 + max(height(of: node.leftChild), height(of: node.rightChild))
    }
}

//MARK: Serialize into Array
extension BinaryTreeNode {
    func serialize(_ node: BinaryTreeNode<T>) -> [T?] {
        var array: [T?] = []
        node.traversePreOrderSerialize(visit: {array.append($0)})
        return array
    }
}

//MARK: Deserialize into BinaryTree from Array
extension BinaryTreeNode {
    private func deserializeII(_ array: inout [T?]) -> BinaryTreeNode<T>? {
        guard !array.isEmpty, let value = array.removeLast() else { return nil }

        let node = BinaryTreeNode(value: value)
        node.leftChild = deserializeII(&array)
        node.rightChild = deserializeII(&array)
        return node
    }
    
    func deserializeI(_ array: [T?]) -> BinaryTreeNode<T>? {
        var reversed = Array(array.reversed())
        return deserializeII(&reversed)
    }
}

//MARK: Pre-order traversal for serialization
extension BinaryTreeNode {
    func traversePreOrderSerialize(visit: (T?) -> Void) {
        visit(self.value)
        if let leftChild = leftChild {
            leftChild.traverseInOrder(visit: visit)
        } else {
            visit(nil)
        }
        if let rightChild = rightChild {
            rightChild.traverseInOrder(visit: visit)
        } else {
            visit(nil)
        }
    }
}

//MARK: Level-order traversal
extension BinaryTreeNode {
    func forEachLevelOrder(visit: (BinaryTreeNode) -> Void) {
        visit(self)
        
        var queue = QueueArray<BinaryTreeNode>()
        
        if let left = leftChild { queue.enqueue(left) }
        if let right = rightChild { queue.enqueue(right) }

        while let treeNode = queue.dequeue() {
            visit(treeNode)
            if let left = treeNode.leftChild { queue.enqueue(left) }
            if let right = treeNode.rightChild { queue.enqueue(right) }
        }
    }
}

extension BinaryTreeNode: CustomStringConvertible {
    var description: String {
        diagram(for: self)
    }
    
    private func diagram(for node: BinaryTreeNode?,
                         _ top: String = "",
                         _ root: String = "",
                         _ bottom: String = "") -> String {
        guard let node = node else {
            return root + "nil\n"
        }
        if node.leftChild == nil && node.rightChild == nil {
            return root + "\(node.value)\n"
        }
        return diagram(for: node.rightChild,
                       top + " ", top + "┌──", top + "│ ")
        + root + "\(node.value)\n"
        + diagram(for: node.leftChild,
                  bottom + "│ ", bottom + "└──", bottom + " ")
    }
}
