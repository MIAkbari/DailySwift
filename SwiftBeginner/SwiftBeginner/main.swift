//
//  main.swift
//  Swift
//
//  Created by Mohammad on 7/26/25.
//

import Foundation

let fibs = [0, 1, 1, 2, 3, 5]

var result = 0

let map = fibs.map { element in
    result = result + element
    return result
}

print(map)

// Like AND Sub TNX
