//
//  ViewController.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 09.08.22.
//

import UIKit

class Solution1 {
    func combine(_ n: Int, _ k: Int) -> [[Int]] {
        guard k <= n else { return [[]] }
        
        var currentArray: [Int] = []
        var result = [[Int]]()
        backtrack(currentNumber: 1, currentArray: &currentArray, result: &result, n: n, k: k)
        return result
    }
    
    private func backtrack(currentNumber: Int, currentArray: inout [Int], result: inout [[Int]], n: Int, k: Int) {

        if currentArray.count == k {
            result.append(currentArray)
        } else {
            let need = k - currentArray.count
            let remain = n - currentNumber + 1
            let available = remain - need

            for i in currentNumber...currentNumber+available {
                currentArray.append(i)
                backtrack(currentNumber: i+1, currentArray: &currentArray, result: &result, n: n, k: k)
                currentArray.removeLast()
            }
            
        }

    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let array: [Character] = ["m", "a", "l", "a", "y", "a", "l", "a", "m"]
        let result = Palindrome.countOfPalindromes(for: array)
        print(result)
    }
    
    func testGoogle() {
        let g = Google()
        let result = g.reachables(startVertices: [1, 2, 5], endVertices: [1, 6, 2], edges: [[1, 5], [1, 4], [5, 3], [3, 2], [2, 6], [4, 6], [5, 6]])
        print(result)
    }
    
    func testBreadthFirstSearch() {
        let graph = AdjacencyListGraph<String>()
        let a = graph.createVertex(data: "A")
        let b = graph.createVertex(data: "B")
        let c = graph.createVertex(data: "C")
        let d = graph.createVertex(data: "D")
        let e = graph.createVertex(data: "E")
        let f = graph.createVertex(data: "F")
        let g = graph.createVertex(data: "G")
        let h = graph.createVertex(data: "H")

        graph.add(.undirected, from: a, to: b, weight: nil)
        graph.add(.undirected, from: a, to: c, weight: nil)
        graph.add(.undirected, from: a, to: d, weight: nil)
        graph.add(.undirected, from: b, to: e, weight: nil)
        graph.add(.undirected, from: c, to: g, weight: nil)
        graph.add(.undirected, from: e, to: f, weight: nil)
        graph.add(.undirected, from: e, to: h, weight: nil)
        graph.add(.undirected, from: f, to: g, weight: nil)
        graph.add(.undirected, from: f, to: c, weight: nil)
        
        let vertices = graph.breadthFirstIterative(from: a)
        vertices.forEach { vertex in
          print(vertex)
        }
    }
    
    func createFriendGraph() {
        let graph = AdjacencyListGraph<String>()
        let vincent = graph.createVertex(data: "vincent")
        let chesley = graph.createVertex(data: "chesley")
        let ruiz = graph.createVertex(data: "ruiz")
        let patrick = graph.createVertex(data: "patrick")
        let ray = graph.createVertex(data: "ray")
        let sun = graph.createVertex(data: "sun")
        let cole = graph.createVertex(data: "cole")
        let kerry = graph.createVertex(data: "kerry")
        
        let a = graph.createVertex(data: "a")
        let b = graph.createVertex(data: "b")
        graph.add(.undirected, from: a, to: b, weight: 1)
        
        graph.add(.undirected, from: vincent, to: chesley, weight: 1)
        graph.add(.undirected, from: vincent, to: ruiz, weight: 1)
        graph.add(.undirected, from: vincent, to: patrick, weight: 1)
        graph.add(.undirected, from: ruiz, to: ray, weight: 1)
        graph.add(.undirected, from: ruiz, to: sun, weight: 1)
        graph.add(.undirected, from: patrick, to: cole, weight: 1)
        graph.add(.undirected, from: patrick, to: kerry, weight: 1)
        graph.add(.undirected, from: cole, to: ruiz, weight: 1)
        graph.add(.undirected, from: cole, to: vincent, weight: 1)
        
//        let vincentsFriends = Set(graph.edges(from: vincent).map{ $0.destination.data })
//        let mutual = vincentsFriends.intersection(graph.edges(from: ruiz).map { $0.destination.data })
//        print(mutual)
        
        let result = graph.pathExists(from: a, to: ruiz)
        print(result)
    }
    
    func constructAdjacencyListGraph() {
        let graph = AdjacencyListGraph<String>()
        
        let singapore = graph.createVertex(data: "Singapore")
        let tokyo = graph.createVertex(data: "Tokyo")
        let hongKong = graph.createVertex(data: "Hong Kong")
        let detroit = graph.createVertex(data: "Detroit")
        let sanFrancisco = graph.createVertex(data: "San Francisco")
        let washingtonDC = graph.createVertex(data: "Washington DC")
        let austinTexas = graph.createVertex(data: "Austin Texas")
        let seattle = graph.createVertex(data: "Seattle")
        
        graph.add(.undirected, from: singapore, to: hongKong, weight:
        300)
        graph.add(.undirected, from: singapore, to: tokyo, weight: 500)
        graph.add(.undirected, from: hongKong, to: tokyo, weight: 250)
        graph.add(.undirected, from: tokyo, to: detroit, weight: 450)
        graph.add(.undirected, from: tokyo, to: washingtonDC, weight:
        300)
        graph.add(.undirected, from: hongKong, to: sanFrancisco, weight:
        600)
        graph.add(.undirected, from: detroit, to: austinTexas, weight:
        50)
        graph.add(.undirected, from: austinTexas, to: washingtonDC,
        weight: 292)
        graph.add(.undirected, from: sanFrancisco, to: washingtonDC,
        weight: 337)
        graph.add(.undirected, from: washingtonDC, to: seattle, weight:
        277)
        graph.add(.undirected, from: sanFrancisco, to: seattle, weight:
        218)
        graph.add(.undirected, from: austinTexas, to: sanFrancisco,
        weight: 297)
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

