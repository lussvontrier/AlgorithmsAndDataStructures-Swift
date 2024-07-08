//
//  MarsExperiments.swift
//  AlgorithmsDataStructures
//
//  Created by Lusine Magauzyan on 08.07.24.
//

import Foundation

// Define a type alias for tools as a tuple containing name, mass, and experiments
typealias Tool = (name: String, mass: Int, experiments: Int)

func backpackProblemSolution(tools: [Tool], capacity: Int) -> String {
    // Save the number of tools in a variable.
    let itemsCount = tools.count
    // Create a table. Each cell should store a number and a list:
    // the number of experiments and the list of tools. For simplicity,
    // add a row with no tools considered and a column with zero container capacity.
    var table = Array(
        repeating: Array(repeating: (0, [String]()), count: capacity + 1),
        count: itemsCount + 1
    )

    // For each tool:
    for rowNumber in 1...itemsCount {
        // Unpack the tuple with tool data.
        let (name, mass, experiments) = tools[rowNumber - 1]
        // For container capacity from 1 to maximum capacity:
        for volume in 1...capacity {
            // If the weight of the tool is less than or equal to
            // the capacity of the considered container.
            if mass <= volume {
                // Calculate the number of experiments for the current tool
                // plus the best solution for the remaining capacity
                // from the previous row.
                let totalExperimentsWithCurrentTool = experiments + table[rowNumber - 1][volume - mass].0
                // Number of experiments in the current column on the previous row:
                let previousResult = table[rowNumber - 1][volume].0
                // If the result with the current tool is better:
                if totalExperimentsWithCurrentTool > previousResult {
                    // Record the number of experiments.
                    table[rowNumber][volume].0 = totalExperimentsWithCurrentTool
                    // Copy the list of tools from the previous row
                    // from the cell equal to the remaining capacity.
                    table[rowNumber][volume].1 = table[rowNumber - 1][volume - mass].1
                    // Add the name of the current tool to the list of tools.
                    table[rowNumber][volume].1.append(name)
                } else {
                    // If the result with the considered tool is worse or the same -
                    // transfer the result from the previous row.
                    table[rowNumber][volume] = table[rowNumber - 1][volume]
                }
            } else {
                // If the mass of the considered tool is greater than the cell capacity -
                // transfer the result from the previous row.
                table[rowNumber][volume] = table[rowNumber - 1][volume]
            }
        }
    }
    // Print the table for verification.
    for row in table {
        print(row)
    }
    // Return a string with the names of the tools
    // from the bottom-right cell of the table, separated by commas.
    return table[itemsCount][capacity].1.joined(separator: ", ")
}

