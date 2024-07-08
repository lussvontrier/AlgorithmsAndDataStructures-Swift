//
//  LinkedList.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 09.08.22.
//

struct LinkedList<T> {
    var head: Node<T>?
    var tail: Node<T>?
    
    var isEmpty: Bool {
        return head == nil
    }
        
    //MARK: Add
    mutating func push(_ value: T) {
        head = Node(value: value, next: head)
        head?.next?.previous = head
        if tail == nil {
            tail = head
        }
    }
    
    mutating func append(_ value: T) {
        let newNode = Node(value: value)
        
        if let tail = tail {
            newNode.previous = tail
            tail.next = newNode
        } else {
            self.head = newNode
        }
        
        self.tail = newNode
    }
    
    mutating func insert(_ value: T, after node: Node<T>) -> Node<T> {
        guard tail !== node else {
            append(value)
            return tail!
        }
        node.next = Node(value: value, next: node.next)
        //update the initial node's next's previous to new node
        node.next?.next?.previous = node.next
        return node.next!
    }
    
    //MARK: Access
    func node(at index: Int) -> Node<T>? {
        guard index >= 0 else { return nil }
        
        var currentNode = head
        var currentIndex = 0
        
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode!.next
            currentIndex += 1
        }
        
        return currentNode
    }
    
    func middleNode() -> Node<T>? {
        
        var slowNode = head
        var fastNode = head
        
        while let nextFastNode = fastNode?.next {
            fastNode = nextFastNode.next
            slowNode = slowNode?.next
        }
        
        return slowNode
    }
    
    //MARK: Remove
    @discardableResult
    mutating func pop() -> T? {
        let value = head?.value
        head = head?.next
        head?.previous = nil
        if isEmpty {
            tail = nil
        }
        return value
    }
    
    ///For double linked list w previous
//    @discardableResult
//    func removeLast() -> Value? {
//        guard let head = head else {
//            return nil
//        }
//
//        guard head.next != nil else {
//            return pop()
//        }
//        let tailValue = tail?.value
//        tail = tail?.previous
//        tail?.next = nil
//        return tailValue
//    }
    
    ///For single linked list w next only
    @discardableResult
    mutating func removeLast() -> T? {
        guard let head = head else {
            return nil
        }
        
        guard head.next != nil else {
            return pop()
        }
        var previous = head
        var current = head
        while let next = current.next {
            previous = current
            current = next
        }
        
        tail = previous
        tail?.next = nil
        return current.value
    }
    
    mutating func remove(after node: Node<T>) -> T? {
        let value = node.next?.value
        
        if node.next === tail {
            tail = node
        }
        node.next = node.next?.next
        node.next?.previous = node
        return value
    }
    
    mutating func remove(node: Node<T>) -> T {
        let previous = node.previous
        let next = node.next
        
        if let previous = previous {
            previous.next = next
        } else {
            self.head = next
        }
        
        next?.previous = previous
        
        if next == nil {
            self.tail = previous
        }
        node.previous = nil
        node.next = nil
        
        return node.value
    }
    
    mutating func removeAll() {
        self.head = nil
        self.tail = nil
    }
    
    //MARK: Modify
    mutating func reverse() {
        tail = head
        var preceding = head
        var current = head?.next
//        preceding?.previous = preceding?.next
        preceding?.next = nil
        while current != nil {
            let subsequent = current?.next
//            current?.previous = subsequent
            current?.next = preceding
            preceding = current
            current = subsequent
        }
        head = preceding
    }
    
    mutating func reverse2() {
        var prev: Node<T>? = nil
        var current = head
        var next: Node<T>? = nil
        
        while current != nil {
            next = current?.next
            current?.next = prev
            prev = current
            current = next
        }
        head = prev
    }
    
    mutating func removeOccurrences<T: Comparable>(of value: T) {
        
        while let head = head, head.value as! T == value {
            self.head = self.head?.next
        }
        
        var previous = head
        var current = head?.next
        
        while let currentNode = current {
            guard currentNode.value as! T != value else {
                previous?.next = currentNode.next
                current = previous?.next
                continue
            }
            previous = current
            current = current?.next
        }
            
        tail = previous
    }
}

//MARK: For print
extension LinkedList: CustomStringConvertible {
    
//    var description: String {
//        guard let head = head else { return "Empty List" }
//        return String(describing: head)
//    }
    
    var description: String {
        var text = "["
        var node = head
        while node != nil {
            text += "\(node!.value)"
            node = node!.next
            if node != nil { text += ", " }
        }
        return text + "]"
    }
}

//MARK: For subscripting
extension LinkedList: Collection {
    
    struct Index: Comparable {
        var node: Node<T>?
        static func ==(lhs: Index, rhs: Index) -> Bool {
            switch (lhs.node, rhs.node) {
            case let (left?, right?):
                return left.next === right.next
            case (nil, nil):
                return true
            default:
                return false
            }
        }
        static func <(lhs: Index, rhs: Index) -> Bool {
            guard lhs != rhs else {
                return false
            }
            let nodes = sequence(first: lhs.node) { $0?.next }
            return nodes.contains { $0 === rhs.node }
        }
    }
    
    var startIndex: Index {
        Index(node: head)
    }
    
    var endIndex: Index {
        Index(node: tail?.next)
    }
    
    public func index(after i: Index) -> Index {
        Index(node: i.node?.next)
    }

    public subscript(position: Index) -> T {
        position.node!.value
    }
}
