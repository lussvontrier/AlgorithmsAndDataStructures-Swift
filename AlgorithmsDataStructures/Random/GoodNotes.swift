//
//  GoodNotes.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 04.03.23.
//

import Foundation

class Smth {
    func GetRejectedRequests(requests: [String], limit_per_second: Int) -> [Int] {
        // Write your code here
        
        var requestIds: [String] = []
        var ipAddress: [String] = []
        var timestampMilisec: [Int] = []
        
        var rejectedRequests: [String] = []
        var timestampsPerIp: [String: [Int]] = [:]
        
        requests.map {
            let arr = $0.components(separatedBy: " ")
            requestIds.append(arr[0])
            ipAddress.append(arr[1])
            timestampMilisec.append(Int(arr[2]) ?? 0)
        }
        
        for i in 0...requestIds.count-1 {
            if timestampsPerIp[ipAddress[i], default: []].isEmpty {
                timestampsPerIp[ipAddress[i], default: []].append(timestampMilisec[i])
            } else {
                if timestampMilisec[i] - timestampsPerIp[ipAddress[i], default: []][0] > 1000 {
                    timestampsPerIp[ipAddress[i]] = [timestampMilisec[i]]
                } else {
                    if timestampsPerIp[ipAddress[i], default: []].count + 1 > limit_per_second {
                        rejectedRequests.append(requestIds[i])
                    } else {
                        timestampsPerIp[ipAddress[i], default: []].append(timestampMilisec[i])
                    }
                }
            }

        }
        
        if rejectedRequests.isEmpty {
            return []
        } else {
            return rejectedRequests.map { Int($0) ?? 0 }
        }
    }
}
