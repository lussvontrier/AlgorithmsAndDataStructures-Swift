//
//  Heap.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 04.10.22.
//

struct Heap<Element: Equatable> {
    var elements: [Element] = []
    let sort: (Element, Element) -> Bool
    
    init(sort: @escaping (Element, Element) -> Bool, elements: [Element] = []) {
        self.sort = sort
        self.elements = elements
        if !elements.isEmpty {
            ///starting from the first non-leaf node
            for i in stride(from: elements.count / 2 - 1, through: 0, by: -1) {
                siftDown(from: i, upTo: count)
            }
        }
    }
    
    var isEmpty: Bool {
        elements.isEmpty
    }
    var count: Int {
        elements.count
    }
    
    func peek() -> Element? {
        elements.first
    }
    func leftChildIndex(ofParentAt index: Int) -> Int {
        (2 * index) + 1
    }
    func rightChildIndex(ofParentAt index: Int) -> Int {
        (2 * index) + 2
    }
    func parentIndex(ofChildAt index: Int) -> Int {
        (index - 1) / 2
    }
}

//MARK: Remove the root
extension Heap {
    mutating func remove() -> Element? {
        guard !isEmpty else {
            return nil
        }
        elements.swapAt(0, count - 1)
        defer {
            siftDown(from: 0, upTo: count)
        }
        return elements.removeLast()
    }
    
    mutating func siftDown(from index: Int, upTo size: Int) {
        var parent = index
        while true {
            let left = leftChildIndex(ofParentAt: parent)
            let right = rightChildIndex(ofParentAt: parent)
            var candidate = parent
            if left < size && sort(elements[left], elements[candidate]) {
                candidate = left
            }
            if right < size && sort(elements[right], elements[candidate]) {
                candidate = right
            }
            if candidate == parent {
                return
            }
            elements.swapAt(parent, candidate)
            parent = candidate
        }
    }
}

//MARK: Remove from any index
extension Heap {
    mutating func remove(at index: Int) -> Element? {
        guard index < count else { return nil }
        if index == count - 1 {
            return elements.removeLast()
        } else {
            elements.swapAt(index, count - 1)
            defer {
                siftUp(from: index)
                siftDown(from: index, upTo: count)
            }
            return elements.removeLast()
        }
    }
}

//MARK: Search
extension Heap {
    func index(of element: Element, startingAt i: Int) -> Int? {
        if i >= count { return nil }
        
        ///If element has higher priority than element at i then it cannot be at the lower level
        if sort(element, elements[i]) { return nil }
        if element == elements[i] { return i }
        
        if let j = index(of: element, startingAt: leftChildIndex(ofParentAt: i)) { return j }
        if let j = index(of: element, startingAt: rightChildIndex(ofParentAt: i)) { return j }
        
        return nil
    }
}

//MARK: Insert
extension Heap {
    mutating func insert(_ element: Element) {
        elements.append(element)
        siftUp(from: count - 1)
    }
    
    mutating func siftUp(from index: Int) {
        var child = index
        var parent = parentIndex(ofChildAt: child)
        while child > 0 && sort(elements[child], elements[parent]) {
            elements.swapAt(child, parent)
            child = parent
            parent = parentIndex(ofChildAt: child)
        }
    }
}

extension Heap {
    ///O(nlogn)
    func sorted() -> [Element] {
        var heap = Heap(sort: sort, elements: elements)
        for index in heap.elements.indices.reversed() {
            heap.elements.swapAt(0, index)
            heap.siftDown(from: 0, upTo: index)
        }
        return heap.elements
    }
}
