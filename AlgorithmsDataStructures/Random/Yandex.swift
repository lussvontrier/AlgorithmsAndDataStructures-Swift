//
//  Yandex.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 29.10.23.
//

import Foundation

/*
Места в кинотеатре расположены в один ряд. Только что пришедший зритель выбирает место,
чтобы сидеть максимально далеко от остальных зрителей в ряду.
То есть расстояние от того места, куда сядет зритель до ближайшего к нему зрителя
должно быть максимально.

Гарантируется, что в ряду всегда есть свободные места и уже сидит хотя бы один зритель.

Напишите функцию, которая по заданному ряду мест (массиву из нулей и единиц)
вернёт расстояние (ЧИСЛО ПРОМЕЖУТКОВ МЕЖДУ КРЕСЛАМИ) от выбранного места до ближайшего зрителя.

findBestSeatDist([1, 0, 0, 0, 1]) -> 2
findBestSeatDist([1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0]) -> 2
findBestSeatDist([1, 0, 1, 0]) -> 1
[0 0 0 1] -> 2
[1 0 0 0 ]


*/
// [1 0 0 1 0 0] 2
func findBestSeatDist(_ seats: [Int]) -> Int {
    let n = seats.count
    var maxDist = 0
    var lastOccupied = -1 // To handle the initial segment before the first occupied seat

    // Scan through the list to find free segments
    for i in 0..<n {
        if seats[i] == 1 {
            if lastOccupied == -1 {
                // This handles the case where there's an initial segment of free seats
                maxDist = max(maxDist, i)
            } else {
                // Calculate the best distance for the middle segment
                let dist = (i - lastOccupied) / 2
                maxDist = max(maxDist, dist)
            }
            lastOccupied = i
        }
    }

    // Check the last segment if it ends with free seats
    if seats[n - 1] == 0 {
        maxDist = max(maxDist, n - 1 - lastOccupied)
    }

    return maxDist
}


//Vadim R. Maksyutov
