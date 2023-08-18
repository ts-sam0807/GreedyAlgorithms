//
//  main.swift
//  GreedyAlgorithms
//
//  Created by Ts SaM on 17/8/2023.
//

import Foundation

func twoCitySchedCost(_ costs: [[Int]]) -> Int {
    let n = costs.count / 2
    var diffCosts = [(Int, Int)]()
    var totalCost = 0
    
    for cost in costs {
        diffCosts.append((cost[0] - cost[1], cost[0]))
    }
    
    diffCosts.sort { $0.0 < $1.0 }
    
    for i in 0..<n {
        totalCost += diffCosts[i].1
    }
    
    for i in n..<2*n {
        totalCost += diffCosts[i].1 - diffCosts[i].0
    }
    
    return totalCost
}

let costs = [[10,20],[30,200],[400,50],[30,20]]
let result = twoCitySchedCost(costs)
print(result)

//-------------------------------------------
//-------------------------------------------

func canAttendMeetings(_ intervals: [[Int]]) -> Bool {
    let sortedIntervals = intervals.sorted { $0[0] < $1[0] }
    
    for i in 1..<sortedIntervals.count {
        if sortedIntervals[i][0] < sortedIntervals[i - 1][1] {
            return false
        }
    }
    return true
}

let intervals1 = [[0,30],[5,10],[15,20]]
print(canAttendMeetings(intervals1))

let intervals2 = [[7,10],[2,4]]
print(canAttendMeetings(intervals2))

//-------------------------------------------
//-------------------------------------------

func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
    var totalGas = 0
    var currentGas = 0
    var station = 0
    
    for i in 0..<gas.count {
        let diff = gas[i] - cost[i]
        totalGas += diff
        currentGas += diff
        
        if currentGas < 0 {
            currentGas = 0
            station = i + 1
        }
    }
    
    return totalGas >= 0 ? station : -1
}

let gas1 = [1,2,3,4,5]
let cost1 = [3,4,5,1,2]
print(canCompleteCircuit(gas1, cost1))

let gas2 = [2,3,4]
let cost2 = [3,4,3]
print(canCompleteCircuit(gas2, cost2))

//-------------------------------------------
//-------------------------------------------

func partitionLabels(_ s: String) -> [Int] {
    let strArray = Array(s)
    var lastIndices = [Int](repeating: 0, count: 26)
    var result = [Int]()
    var start = 0
    var end = 0
    
    for (index, char) in strArray.enumerated() {
        let charIndex = Int(char.asciiValue! - Character("a").asciiValue!)
        lastIndices[charIndex] = index
    }
    
    for (index, char) in strArray.enumerated() {
        let charIndex = Int(char.asciiValue! - Character("a").asciiValue!)
        end = max(end, lastIndices[charIndex])
        
        if index == end {
            result.append(end - start + 1)
            start = end + 1
        }
    }
    
    return result
}

let s1 = "ababcbacadefegdehijhklij"
print(partitionLabels(s1))

let s2 = "eccbbbbdec"
print(partitionLabels(s2))

//-------------------------------------------
//-------------------------------------------

func leastInterval(_ tasks: [Character], _ n: Int) -> Int {
    var taskCount = [Int](repeating: 0, count: 26)
    
    for task in tasks {
        let index = Int(task.asciiValue! - Character("A").asciiValue!)
        taskCount[index] += 1
    }
    
    taskCount.sort(by: >)
    
    let maxFreq = taskCount[0]
    var maxFreqCount = 0
    
    for count in taskCount {
        if count == maxFreq {
            maxFreqCount += 1
        } else {
            break;
        }
    }
    
    let partitionCount = maxFreq - 1
    let emptySlots = partitionCount * (n - (maxFreqCount - 1))
    let availableTasks = tasks.count - (maxFreq * maxFreqCount)
    let idleSlots = max(0, emptySlots - availableTasks)
    
    return tasks.count + idleSlots
}

let tasks1: [Character] = ["A","A","A","B","B","B"], n = 0
let n1 = 0
print(leastInterval(tasks1, n1))

let tasks2: [Character] = ["A","A","A","A","A","A","B","C","D","E","F","G"]
let n2 = 2
print(leastInterval(tasks2, n2))
