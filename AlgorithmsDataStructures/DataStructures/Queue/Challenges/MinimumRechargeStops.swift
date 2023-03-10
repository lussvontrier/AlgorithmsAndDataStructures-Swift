//
//  MinimumRechargeStops.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 16.10.22.
//

struct ChargingStation {
  /// Distance from start location.
  let distance: Int
  /// The amount of electricity the station has to charge a car.
  /// 1 capacity = 1 mile
  let chargeCapacity: Int
}

enum DestinationResult {
  /// Able to reach your destination with the minimum number of stops.
  case reachable(rechargeStops: Int)
  /// Unable to reach your destination.
  case unreachable
}

/// Returns the minimum number of charging stations an electric vehicle needs to reach it's destination.
/// - Parameter target: the distance in miles the vehicle needs to travel.
/// - Parameter startCharge: the starting charge you have to start the journey.
/// - Parameter stations: the charging stations along the way.
func minRechargeStops(target: Int, startCharge: Int, stations: [ChargingStation]) -> DestinationResult {
    
    guard startCharge < target else { return .reachable(rechargeStops: 0)}
    
    var minStops = -1
    var currentCharge = 0
    var currentStation = 0
    
    var chargePriority = PriorityQueueHeap(sort: >, elements: [startCharge])
    
    while !chargePriority.isEmpty {
        guard let charge = chargePriority.dequeue() else { return .unreachable}
        
        currentCharge += charge
        minStops += 1
        
        if currentCharge >= target {
            return .reachable(rechargeStops: minStops)
        }
        
        while currentStation < stations.count && currentCharge >= stations[currentStation].distance {
            _ = chargePriority.enqueue(stations[currentStation].chargeCapacity)
            currentStation += 1
        }
    }
    
    return .unreachable
}
