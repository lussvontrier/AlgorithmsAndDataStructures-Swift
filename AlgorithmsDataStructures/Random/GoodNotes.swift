//
//  GoodNotes.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 04.03.23.
//

import Foundation

class Solution {
    func getRejectedRequests(requests: [String], limitPerSecond: Int) -> [Int] {
        var timestampsByIp: [String: [Int]] = [:]
        var rejectedRequestIDs: [Int] = []

        for request in requests {
            let components = request.components(separatedBy: " ")
            guard let requestID = Int(components[0]),
                  let timestamp = Int(components[2]) else { continue }

            let ip = components[1]
            let currentTimestamps = timestampsByIp[ip, default: []]

            if let firstTimestamp = currentTimestamps.first,
               timestamp - firstTimestamp <= 1000,
               currentTimestamps.count >= limitPerSecond {
                rejectedRequestIDs.append(requestID)
            } else {
                timestampsByIp[ip] = currentTimestamps.filter { timestamp - $0 <= 1000 } + [timestamp]
            }
        }

        return rejectedRequestIDs
    }
}
