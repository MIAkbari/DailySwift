//
//  main.swift
//  Swift
//
//  Created by Mohammad on 8/26/03.
//

import Foundation

func listNode(_ l1: [Int], _ l2: [Int]) -> [Int] {
    let revL1 = l1.reversed().compactMap({$0})
    let revL2 = l2.reversed().compactMap({$0})
    var array: [Int] = []
    
    if let strL1 = Int(revL1.map(String.init).joined()), let strL2 = Int(revL2.map(String.init).joined()) {
        let final = Array(String(strL1 + strL2)).reversed().compactMap({$0})
        
        final.forEach { char in
            if let number = Int(String(char)) {
                array.append(number)
            }
        }
    }
    
    
    return array
}

// MARK: - Like & Sub - Support Me

/*
 Input: l1 = [2,4,3], l2 = [5,6,4]
 Output: [7,0,8]
 Explanation: 342 + 465 = 807.
 */

print(listNode([2,4,3], [5,6,4]))

func twoSum(_ nums: [Int], _ target: Int) -> (Int,Int)? {
    var dic:[Int: Int] = [:]
    
    for (i, n) in nums.enumerated() {
        if let j = dic[target - n] { return (j, i)}
        dic[n] = i
    }
    
    return nil
}
