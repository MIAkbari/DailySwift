//
//  Collection.swift
//  SwiftBeginner
//
//  Created by Mohammad on 8/2/25.
//

import Foundation

func collectionCustomMap() {
    // The Fibonancci Numbers
    let fibs = [0,1,1,2,3,5]
    
    var squared: [Int] = []
    // out Map
    for fib in fibs {
        squared.append(fib * fib)
    }
    print(squared)
    
    // with map
    
    let squ = fibs.map { fib in fib * fib}
    
    print(squ)
    
    // with custom map
    // The map method isn't hard to write???
    
    
    
    let customMap = fibs.customMap {$0 * $0}
    
    print(customMap)
    
    // Like and sub me - TNX
    
}

extension Array {
    func customMap<T>(_ transform: (Element) -> T) -> [T] {
        var result: [T] = []
        result.reserveCapacity(count)
        
        self.forEach { element in
            result.append(transform(element))
        }
        
        return result
    }
    
    func customSplit(where condition: (Element, Element) -> Bool) -> [[Element]] {
        var result: [[Element]] = self.isEmpty ? [] : [[self[0]]]
        
        zip(self, self.dropFirst())
            .forEach { prev, curr in
                if condition(prev, curr) {
                    result.append([curr])
                } else {
                    result[result.endIndex-1].append(curr)
                }
            }
        return result
    }
}




func collection() {
    
    let array: [Int] = [1, 2, 2, 2, 3, 4, 4, 6,6 , 5, 5]
    //        .sorted(by: <)
    //        .customMap({$0 * $0})
    //
    //    var result: [[Int]] = array.isEmpty ? [] : [[array[0]]]
    //
    //    zip(array,
    //        array.dropFirst())
    //    .forEach { prev, curr in
    //        if prev == curr {
    //            result[result.endIndex-1].append(curr)
    //        } else {
    //            result.append([curr])
    //        }
    //    }
    //
    let result = array.customSplit { $0 != $1 }
    let resultVersion2 = array.customSplit(where: !=)
    print(result)
    print(resultVersion2)
}

func hightOrderFunctions() {
    let numbers = [10, 20, 30, 40, 30, 50]
    //[ 0,  1,  2,  3,  4,  5]
    if let indexWhere = numbers.firstIndex(where: {$0 > 35}) {
        print(indexWhere)
    }
    
    if let lastIndexWhere = numbers.lastIndex(where: {$0 > 35}) {
        print(lastIndexWhere)
    }
    
    let indexOf = numbers.firstIndex(of: 30)
    print(indexOf)
    
    let firstWhere = numbers.first(where: {$0 > 25})
    print(firstWhere)
    
    let lastWhere = numbers.last(where: {$0 > 35})
    print(lastWhere)
    
    // Contains
    let containsElement = numbers.contains(where: {$0 < 5})
    print(containsElement)
    
    
    let data = ["ab", "ab", "abcd", "fd", "fd", "ac", "acd"]
    
    var dataResult: [[String]] = data.isEmpty ? [] : [[data[0]]]
    
    zip(data, data.dropFirst())
        .forEach { pre, cur in
            if pre == cur {
                dataResult[dataResult.endIndex-1].append(cur)
            } else {
                dataResult.append([cur])
            }
        }
    print(dataResult)
//    var result = data.customSplit(where: !=)
//    print(result)
    
    let suits = ["♠", "♥", "♣", "♦"]
    let ranks = ["J", "Q", "K", "A"]
    
    _ = suits.flatMap { sui in
        ranks.map { rank in
            let final = (sui, rank)
            print(final)
        }
    }
    
    let dataPlus = [1,2,3,4]//.accmulate(0, +) //.reduce(0, +)
    var resultData = 0
    
    let accmulate = dataPlus.map { element in
        resultData = resultData + element
        return resultData
    }
    print(accmulate)

    let letters = ["A", "B", "C"]//.accmulate("", +)
    
    var resultLetters = ""
    let lettersAccumlate = letters.map { element in
        resultLetters = resultLetters + element
        return resultLetters
    }
    print(lettersAccumlate)
}

extension Array {
    func accmulate<T>(_ initResult: T,
                      _ nextPartialResult: (T, Element) -> T)
    -> [T] {
        var result = initResult
        let accmulate = map { next in
            result = nextPartialResult(result, next)
            return result
        }
        return accmulate
    }
    
    func customFilter(_ isIncluded: (Element) -> Bool) -> [Element] {
        var result: [Element] = []
        for x in self where isIncluded(x) {
            result.append(x)
        }
        return result
    }
    
    func customFlatMap<T>(_ transform: (Element) -> [T]) -> [T]{
        var result: [T] = []
        
        for x in self {
            result.append(contentsOf: transform(x))
        }
        return result
    }
    
    func customReduce<Result>(_ initResult: Result, _ nextPartialResult: (Result, Element) -> Result) -> Result {
        var result = initResult
        for x in self {
            result = nextPartialResult(result, x)
        }
        return result
    }
}

extension Array where Element: Equatable {
    
    func customFirstindex(of element: Element) -> Int? {
        for idx in self.indices where self[idx] == element {
            return idx
        }
        return nil
    }
}


func filterFunc() {
    let nums = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    var result: [Int] = []
    for element in nums where element % 2 == 0 {
        result.append(element)
    }
    print(nums.customFilter({$0 % 2 == 0}))
    print(result)
    
    let fibs = [0, 1, 1, 2, 3, 5]
    var resultFibs = 0
    
    let acc = fibs.map { element in
        resultFibs = resultFibs + element
        return resultFibs
    }
    
    print(acc)
    
    resultFibs = 0
    fibs.forEach { element in
        resultFibs = resultFibs + element
    }
    
    print(resultFibs)
    print(fibs.customReduce(0, +))
    
    //
    let slice = [1...]
    
    print(slice)
}

func dictionaryMethod() {
    
    var data: [String: String] = [:]
    
    data["name"] = "mohammad"
    data["family"] = "akbari"
    
    data.updateValue("tehran", forKey: "city")
    var finalData: [String: String] = [:]
    finalData["village"] = "sefidar"
    
    let merge = data.merging(finalData, uniquingKeysWith: {$1})
    
    print(merge)
    
    let frequencies = "hellooo"
    let arr = Array(frequencies)
    
    let split = arr.customSplit(where: !=)
    let sp = split.map {($0, $0.count)}
    
    let fre = frequencies.map{($0,1)}
    let dic = Dictionary(fre, uniquingKeysWith: +)
    
    print(dic)
    print(frequencies.frequencies.filter({$0.value > 2}))
    print(arr.customFrequencies)
}

extension Sequence where Element: Hashable {
    var frequencies: [Element: Int] {
        let frequenciesPairs = self.map {($0, 1)}
        return Dictionary(frequenciesPairs, uniquingKeysWith: +)
    }
}

extension Array where Element: Equatable {
    var customFrequencies:[([Element], Int)] {
        let fre = self.customSplit(where: !=)
        let frequenciesPairs = fre.map {($0, $0.count)}
        return frequenciesPairs
    }
}


func checkSet() {
    let iPods: Set = ["iPod touch", "iPod nano", "iPod mini",
    "iPod shuffle", "iPod classic"]
    let discontinuedIPods: Set = ["iPod mini", "iPod classic",
    "iPod nano", "iPod shuffle"]
    
    let check = iPods.subtracting(discontinuedIPods) // iPod touch
    
    let touchscreen: Set = ["iPhone", "iPad", "iPod touch", "iPod nano"]
    
    let inter = iPods.intersection(touchscreen) // "iPod touch", "iPod nano"
    
    var discontinued: Set = ["iBook", "PowerBook", "Power Mac"]
    
    discontinued.formUnion(discontinuedIPods) // "iPod classic", "Power Mac", "iPod nano", "iPod shuffle", "iBook", "iPod mini", "PowerBook"
    
  _ = [1,2,3,12,1,3,4,5,6,4,6]//.unique() // [1, 2, 3, 12, 4, 5, 6]
}


extension Sequence where Element: Hashable {
//    func unique() -> [Element] {
//        var result: Set<Element> = []
//        
//        let filter = self.filter { element in
//            if result.contains(element) {
//                return false
//            } else {
//                result.insert(element)
//                return true
//            }
//        }
//        
//        return filter
//    }
    
    func toArray() -> [Element] {
        Array(self)
    }
}

func rangeOfSwift() {
    let base = 0...10
    print(base.toArray())
    
    let lowercaseLetters = Character("a")...Character("z")
    print(lowercaseLetters)
    
    let fromA: PartialRangeFrom<Character> = Character("a")...
    let throughZ: PartialRangeThrough<Character> = ...Character("z")
    let upto10: PartialRangeUpTo<Int> = ..<10
    
    print(fromA)
    print(throughZ)
    print(upto10)
    
    let numbers = [1,2,3,4]
    numbers[2...] // [3, 4]
    numbers[..<1] // [1]
    numbers[1...2] // [2, 3]
    
    let num = numbers[...]
    
    print(num)
}

