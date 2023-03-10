// Copyright (c) 2021 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

struct RingBuffer<T> {
  
  private var array: [T?]
  private var readIndex = 0
  private var writeIndex = 0
  
  init(count: Int) {
    array = Array<T?>(repeating: nil, count: count)
  }
  
  var first: T? {
    array[readIndex]
  }
  
  mutating func write(_ element: T) -> Bool {
    if !isFull {
      array[writeIndex % array.count] = element
      writeIndex += 1
      return true
    } else {
      return false
    }
  }
  
  mutating func read() -> T? {
    if !isEmpty {
      let element = array[readIndex % array.count]
      readIndex += 1
      return element
    } else {
      return nil
    }
  }
  
  private var availableSpaceForReading: Int {
    writeIndex - readIndex
  }
  
  var isEmpty: Bool {
    availableSpaceForReading == 0
  }
  
  private var availableSpaceForWriting: Int {
    array.count - availableSpaceForReading
  }
  
  var isFull: Bool {
    availableSpaceForWriting == 0
  }
}

extension RingBuffer: CustomStringConvertible {
  var description: String {
    let values = (0..<availableSpaceForReading).map {
      String(describing: array[($0 + readIndex) % array.count]!)
    }
    return "[" + values.joined(separator: ", ") + "]"
  }
}
