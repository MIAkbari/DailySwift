//
//  main.swift
//  SwiftBeginner
//
//  Created by Mohammad on 7/26/25.
//

import Foundation

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

extension Array {
    func customMap<T>(_ transform: (Element) -> T) -> [T] {
        var result: [T] = []
        result.reserveCapacity(count)
        for x in self {
            result.append(transform(x))
        }
        return result
    }
}

let customMap = fibs.customMap {$0 * $0}

print(customMap)

// Like and sub me - TNX
