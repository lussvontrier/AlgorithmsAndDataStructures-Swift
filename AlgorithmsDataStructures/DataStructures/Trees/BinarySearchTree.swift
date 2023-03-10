//
//  BinarySearchTree.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 12.09.22.
//

///AVL i.e. balanced
struct BinarySearchTree<T: Comparable> {
    private(set) var root: BinaryTreeNode<T>?
    init() {}
}

//MARK: Insertion O(logn)
extension BinarySearchTree {
    mutating func insert(_ value: T) {
        root = insert(from: root, value: value)
    }
    
    private func insert(from node: BinaryTreeNode<T>?, value: T) -> BinaryTreeNode<T> {
        
        guard let node = node else {
            return BinaryTreeNode(value: value)
        }
        
        if value < node.value {
            node.leftChild = insert(from: node.leftChild, value: value)
        } else {
            node.rightChild = insert(from: node.rightChild, value: value)
        }
        ///the below gets called on every parent node leading to the one to be removed, thus all will be balanced
        let balancedNode = balanced(node)
        balancedNode.height = max(balancedNode.leftHeight, balancedNode.rightHeight) + 1
        return balancedNode
    }
}


//MARK: Remove
extension BinarySearchTree {
    mutating func remove(_ value: T) {
        root = remove(node: root, value: value)
    }
    
    private func remove(node: BinaryTreeNode<T>?, value: T) -> BinaryTreeNode<T>? {
        guard let node = node else {
            return nil
        }
        
        if value == node.value {
            ///If the node is a leaf node, return nil, thereby removing the current node
            if node.leftChild == nil && node.rightChild == nil {
                return nil
            }
            
            ///If the node has no leftChild, return rightchild to reconnect the right subtree
            if node.leftChild == nil {
                return node.rightChild
            }
            ///If the node has no rightChild, return leftchild to reconnect the left subtree
            if node.rightChild == nil {
                return node.leftChild
            }
            
            ///Case where the node to be removed has both right and left child
            node.value = node.rightChild!.min.value
            node.rightChild = remove(node: node.rightChild, value: node.value)
        } else if value < node.value {
            node.leftChild = remove(node: node.leftChild, value: value)
        } else {
            node.rightChild = remove(node: node.rightChild, value: value)
        }
        ///the below gets called on every parent node leading to the one to be removed, thus all will be balanced
        let balancedNode = balanced(node)
        balancedNode.height = max(balancedNode.leftHeight, balancedNode.rightHeight) + 1
        return balancedNode
    }
}

//MARK: Rotations
extension BinarySearchTree {
    private func leftRotate(_ node: BinaryTreeNode<T>) -> BinaryTreeNode<T> {
        let pivot = node.rightChild!
        node.rightChild = pivot.leftChild
        pivot.leftChild = node
        
        node.height = max(node.leftHeight, node.rightHeight) + 1
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
        return pivot
    }
    
    private func rightRotate(_ node: BinaryTreeNode<T>) -> BinaryTreeNode<T> {
        let pivot = node.leftChild!
        node.leftChild = pivot.rightChild
        pivot.rightChild = node
        
        node.height = max(node.leftHeight, node.rightHeight) + 1
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
        return pivot
    }
    
    private func rightLeftRotate(_ node: BinaryTreeNode<T>) -> BinaryTreeNode<T> {
        guard let rightChild = node.rightChild else { return node }
        node.rightChild = rightRotate(rightChild)
        return leftRotate(node)
    }
    
    private func leftRightRotate(_ node: BinaryTreeNode<T>) -> BinaryTreeNode<T> {
        guard let leftChild = node.leftChild else { return node }
        node.leftChild = leftRotate(leftChild)
        return rightRotate(node)
    }
    
    private func balanced(_ node: BinaryTreeNode<T>) -> BinaryTreeNode<T> {
        switch node.balanceFactor {
        case 2:
            if let leftChild = node.leftChild, leftChild.balanceFactor == -1 {
                return leftRightRotate(node)
            } else {
                return rightRotate(node)
            }
        case -2:
            if let rightChild = node.rightChild, rightChild.balanceFactor == 1 {
                return rightLeftRotate(node)
            } else {
                return leftRotate(node)
            }
        default:
            return node
        }
    }

}

//MARK: Find
extension BinarySearchTree {
    func containsN(_ value: T) -> Bool {
        guard let root = self.root else { return false }
        var contains = false
        root.traverseInOrder(visit: {
            if $0 == value {
                contains = true
            }
        })
        return contains
    }
    
    func containsLogN(_ value: T) -> Bool {
        var current = root
        while let node = current {
            if value == node.value {
                return true
            }
            
            if value < node.value {
                current = node.leftChild
            } else {
                current = node.rightChild
            }
        }
        return false
    }
}

extension BinarySearchTree: Equatable {
    static func == (lhs: BinarySearchTree<T>, rhs: BinarySearchTree<T>) -> Bool {
        isEqual(lhs.root, rhs.root)
    }
    
    private static func isEqual<T: Equatable>(_ node1: BinaryTreeNode<T>?, _ node2: BinaryTreeNode<T>?) -> Bool {
        
        guard let leftNode = node1, let rightNode = node2 else {
            return node1 == nil && node2 == nil
        }
        
        return leftNode.value == rightNode.value &&
        isEqual(leftNode.leftChild, rightNode.leftChild) &&
        isEqual(leftNode.rightChild, rightNode.rightChild)
    }
}

//MARK: Check if the current BST contains all the elements of another tree
extension BinarySearchTree where T: Hashable {
    func contains(_ subtree: BinarySearchTree) -> Bool {
        var set: Set<T> = []
        root?.traverseInOrder {
            set.insert($0)
        }
        var isEqual = true
        subtree.root?.traverseInOrder {
            isEqual = isEqual && set.contains($0)
        }
        return isEqual
    }
}

extension BinarySearchTree: CustomStringConvertible {
    var description: String {
        guard let root = root else { return "empty tree" }
        return String(describing: root)
    }
}
