//
//  MergeSortLinkedList.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 18.07.23.
//

import Foundation

class MergeSortLinkedList {
    func mergeSort<T: Comparable>(_ head: Node<T>?) -> Node<T>? {
        guard let head = head, head.next != nil else { return head }
        
        var slow: Node<T>? = head
        var fast: Node<T>? = head
        var prev: Node<T>? = nil
        
        while fast != nil && fast!.next != nil {
            prev = slow
            slow = slow!.next
            fast = fast!.next?.next
        }
        
        prev?.next = nil
        
        let left = mergeSort(head)
        let right = mergeSort(slow)
        
        return merge(left, right)
    }
    
    private func merge<T: Comparable>(_ left: Node<T>?, _ right: Node<T>?) -> Node<T>? {
        guard let left = left else {
            return right
        }
        guard let right = right else {
            return left
        }
        
        let head: Node<T>?
        
        if left.value < right.value {
            head = left
            left.next = merge(left.next, right)
        } else {
            head = right
            right.next = merge(left, right.next)
        }
        
        return head
    }
}
