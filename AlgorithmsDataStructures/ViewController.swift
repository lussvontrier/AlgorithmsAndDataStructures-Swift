//
//  ViewController.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 09.08.22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var board: [[Character]] = [["5","3",".",".","7",".",".",".","."],["6",".",".","1","9","5",".",".","."],[".","9","8",".",".",".",".","6","."],["8",".",".",".","6",".",".",".","3"],["4",".",".","8",".","3",".",".","1"],["7",".",".",".","2",".",".",".","6"],[".","6",".",".",".",".","2","8","."],[".",".",".","4","1","9",".",".","5"],[".",".",".",".","8",".",".","7","9"]]
        
        let solver = SudokuSolver()
        solver.solveSudoku(&board)
        
    }
    
    func getNthSmallestElement(n: Int, elements: [Int]) -> Int? {
        var heap = Heap(sort: <, elements: elements)
        var current = 1
        while !heap.isEmpty {
            let element = heap.remove()
            if current == n {
                return element
            }
            current += 1
        }
        return nil
    }
        
    //MARK: BinaryTree
    func createBinaryTree() -> BinaryTreeNode<Int> {
        let zero = BinaryTreeNode(value: 0)
        let one = BinaryTreeNode(value: 1)
        let five = BinaryTreeNode(value: 5)
        let seven = BinaryTreeNode(value: 7)
        let eight = BinaryTreeNode(value: 8)
        let nine = BinaryTreeNode(value: 9)
        seven.leftChild = one
        one.leftChild = zero
        one.rightChild = five
        seven.rightChild = nine
        nine.leftChild = eight
        return seven
    }
    
    //MARK: Binary Search
    func binarySearch<Elements: RandomAccessCollection>(
         for element: Elements.Element,
         in collection: Elements,
         in range: Range<Elements.Index>? = nil) -> Elements.Index? where Elements.Element: Comparable {
             
        let range = range ?? collection.startIndex..<collection.endIndex
        guard range.lowerBound < range.upperBound else {
            return nil
        }
        let size = collection.distance(from: range.lowerBound,
                                       to: range.upperBound)
        let middle = collection.index(range.lowerBound, offsetBy: size / 2)
        if collection[middle] == element {
            return middle
        } else if collection[middle] > element {
            return binarySearch(for: element,
                                in: collection,
                                in: range.lowerBound..<middle)
        } else {
            return binarySearch(for: element,
                                in: collection,
                                in: collection.index(after: middle)..<range.upperBound)
        }
    }
    
    func findIndices<Elements: RandomAccessCollection>(of element: Elements.Element, in collection: Elements) -> Range<Elements.Index>? where Elements.Element: Comparable {
        var firstIndex: Elements.Index
        var lastIndex: Elements.Index
        
        guard let index = binarySearch(for: element, in: collection) else { return nil }
        var first = index
        var last = index
        while collection[collection.index(before: first)] == element {
            first = collection.index(before: first)
        }
        while collection[collection.index(after: last)] == element {
            last = collection.index(after: last)
        }
        firstIndex = first
        lastIndex = last
        return first..<collection.index(after: last)
    }
    
    //MARK: Tree
    
    func printEachLevel<T>(for tree: TreeNode<T>) {
        
        var queue = QueueForChallenge<TreeNode<T>>()
        var nodesLeftInCurrentLevel = 0
        queue.enqueue(tree)
                
        while !queue.isEmpty {
            nodesLeftInCurrentLevel = queue.count
            
            while nodesLeftInCurrentLevel > 0 {
                guard let node = queue.dequeue() else { break }
                print("\(node.value) ", terminator: "")
                node.children.forEach { queue.enqueue($0) }
                nodesLeftInCurrentLevel -= 1
            }
            print()
        }
    }
    
    func makeBeverageTree() -> TreeNode<String> {
        let tree = TreeNode("Beverages")
        let hot = TreeNode("hot")
        let cold = TreeNode("cold")
        let tea = TreeNode("tea")
        let coffee = TreeNode("coffee")
        let chocolate = TreeNode("cocoa")
        let blackTea = TreeNode("black")
        let greenTea = TreeNode("green")
        let chaiTea = TreeNode("chai")
        let soda = TreeNode("soda")
        let milk = TreeNode("milk")
        let gingerAle = TreeNode("ginger ale")
        let bitterLemon = TreeNode("bitter lemon")
        tree.add(hot)
        tree.add(cold)
        hot.add(tea)
        hot.add(coffee)
        hot.add(chocolate)
        cold.add(soda)
        cold.add(milk)
        tea.add(blackTea)
        tea.add(greenTea)
        tea.add(chaiTea)
        soda.add(gingerAle)
        soda.add(bitterLemon)
        return tree
    }
    
    //MARK: Stack
    func reverseArrayViaStack() {
        let array = [1, 2, 3]
        var stack = Stack(array)
        
        while let lastElement = stack.pop() {
            print(lastElement)
        }
    }
    
    func isBalanced(for string: String) -> Bool {
        var stack = Stack<Character>()
        
        for charachter in string {
            if charachter == "(" {
                stack.push(charachter)
            } else if charachter == ")" {
                if stack.isEmpty {
                    return false
                } else {
                    stack.pop()
                }
            }
        }
        return stack.isEmpty
    }

    //MARK: LinkedList
    func reverseLinkedList() {
        var dogBreeds = LinkedList<String>()
        dogBreeds.append("Labrador")
        dogBreeds.append("Bulldog")
        dogBreeds.append("Beagle")
        dogBreeds.append("Husky")
        print("initial: \(dogBreeds)")
        dogBreeds.reverse()
        print("reversed: \(dogBreeds)")
        print("2nd Dog: \(dogBreeds.node(at: 1)!.value)")
        print("2nd Dog's previous: \(dogBreeds.node(at: 1)!.previous!.value)")
        print("2nd Dog's next: \(dogBreeds.node(at: 1)!.next!.value)")
    }
    
    func printInReverse() {
        var list = LinkedList<Int>()
         list.push(3)
         list.push(2)
         list.push(1)
         print("Original list: \(list)")
         print("Printing in reverse:")
        printInReverse(list)
    }
    
    func mergeSortedLists(left: LinkedList<Int>, right: LinkedList<Int>) -> LinkedList<Int> {
        
        guard !left.isEmpty else { return right }
        guard !right.isEmpty else { return left }
        
        var mergedHead: Node<Int>?
        var mergedTail: Node<Int>?
        
        var currentLeft = left.head
        var currentRight = right.head
        
        if let leftNode = currentLeft, let rightNode = currentRight {
            if leftNode.value < rightNode.value {
                mergedHead = leftNode
                currentLeft = leftNode.next
            } else {
                mergedHead = rightNode
                currentRight = rightNode.next
            }
            mergedTail = mergedHead
        }
        
        while let leftNode = currentLeft, let rightNode = currentRight {
            if leftNode.value < rightNode.value {
                mergedTail?.next = leftNode
                currentLeft = currentLeft?.next
            } else {
                mergedTail?.next = rightNode
                currentRight = currentRight?.next
            }
            mergedTail = mergedTail?.next
        }
        
        if let leftNodes = currentLeft {
            mergedTail?.next = leftNodes
        }
        
        if let rightNodes = currentRight {
            mergedTail?.next = rightNodes
        }
        
        var mergedList = LinkedList<Int>()
        mergedList.head = mergedHead
        mergedList.tail = {
            while let tail = mergedTail?.next {
                mergedTail = tail
            }
            return mergedTail
        }()
        return mergedList
    }
    
    //MARK: Print challenges
    func printInReverse<T>(_ linkedlist: LinkedList<T>) {
        printInReverse(linkedlist.head)
    }
    
    private func printInReverse<T>(_ node: Node<T>?) {
        guard let node = node else { return }
        printInReverse(node.next)
        print(node.value)
    }
}

