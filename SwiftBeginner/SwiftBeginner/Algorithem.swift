//
//  Algorithem.swift
//  SwiftBeginner
//
//  Created by Mohammad on 8/5/25.
//

import Foundation

//func totalFruit(_ fruits: [Int]) -> Int {
//    var maxCount: Int = 0
//    var basket: [Int: Int] = [:]
//    var left = 0
//    
//    for (right, friut) in fruits.enumerated() {
//        basket[friut] = (basket[friut] ?? 0) + 1
//        
//        while basket.count > 2 {
//            let leftfriut = fruits[left]
//            basket[leftfriut]! -= 1
//            if basket[leftfriut] == 0 {
//                basket.removeValue(forKey: leftfriut)
//            }
//            
//            left += 1
//        }
//        maxCount = max(maxCount, right - left + 1)
//    }
//    return maxCount
//}
//
////let data = totalFruit([1,2,3,2,2])
////print(data)
//
//func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
// []
//}
//
//let sum = twoSum([3,2,4], 6)
//print(sum)
//
//
//func mathNumber(_ numbers: [Int]) -> Int {
//    let filter = numbers.filter({ $0 % 2 == 0})
//    return filter.reduce(0, +)
//}
//
//let num = mathNumber([1, 2, 3, 4])
//
//print(num)
//
//var myArray = [-1, 0, 5, -2, 3]
//var result: Int = 0
//myArray.forEach { element in
//    if element > 0 {
//        result = result + 1
//    }
//}
//
//print(result)
//
//let myLet = "swwift"
//
//let frq = myLet.frequencies
//
//frq.forEach { key, value in
//    if value > 1 {
//        print(key)
//    } else {
//        print("key: \(key) = value: \(value)")
//    }
//}
//
//let one = "listen".sorted(by: <)
//let two = "silent".sorted(by: <)
//let final = one == two
//print(final)
//
//
//let reversArray = [1, 2, 3, 4]//.reversed()
//var reResult: [Int] = []
//
//_ = reversArray.map({ element in
//    if element < reversArray.last ?? 0 {
//        reResult.append(element)
//    } else {
//        reResult.append(reversArray.last ?? 0)
//    }
//})
//
//print(reResult)
//
//let lettersss = "abcabcbb"

//func towNumberPointer(_ nums: [Int], target: Int) -> (Int, Int)? {
//    var left = 0
//    var right = nums.count - 1
//
//    while left < right {
//        let sum = nums[left] + nums[right]
//
//        if sum == target {
//            return (-nums.index(before: left), nums.index(after: right))
//        } else if sum < target {
//            left += 1
//        } else {
//            right -= 1
//        }
//    }
//    return nil
//}
//
//print(towNumberPointer([2, 7, 11, 15], target: 9  ))

func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    let sortedArray = (nums1 + nums2).sorted()
    let count = sortedArray.count
    
    if count % 2 == 1 {
        return Double(sortedArray[count / 2])
    } else {
        let middle1 = Double(sortedArray[count / 2])
        let middle2 = Double(sortedArray[(count / 2) - 1])
        return Double(middle1 + middle2) / 2.0
    }
}
