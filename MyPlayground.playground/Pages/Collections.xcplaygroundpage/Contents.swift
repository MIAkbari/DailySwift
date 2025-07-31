import UIKit

var someArray: [Int] = [0,1,1,2,3,5,8]

someArray.dropFirst()
someArray.dropLast(4)
someArray.firstIndex { $0 == 12}
someArray.map({$0 * $0})

var sqaurd: [Int] = []
for fib in someArray {
    sqaurd.append(fib * fib)
}
sqaurd.map({$0})
someArray.filter( {$0 > 20})


for (number, arr) in zip(someArray.indices, someArray) {
   // print(number, ">>> ", arr)
}
for (number, arr) in someArray.enumerated() {
   // print(number, ">>> ", arr)
}

var errArray: [Int] = []

errArray.isEmpty
//errArray.removeLast() error becuse not mach

// map
extension Array {
    func customMap<T>(_ transform: (Element) -> T) -> [T] {
        var result:[T] = []
        result.reserveCapacity(count)
        forEach { index in
            result.append(transform(index))
        }
        return result
    }
}

sqaurd.customMap({$0})
sqaurd.compactMap({$0})
sqaurd.allSatisfy({$0 > 12})
sqaurd.reduce(0, +)
sqaurd.sort(by: {$0 > $1})
sqaurd.sorted(by: {$0 > $1})
sqaurd.partition(by: {$0 < 64})
sqaurd.lexicographicallyPrecedes(errArray, by: {$0 > $1})
sqaurd.firstIndex(where: {$0 < 1})
sqaurd.prefix(while: {$0 < 4})

let array: [Int] = [1, 2, 2, 2, 3, 4, 4]
//var result: [[Int]] = array.isEmpty ? [] : [[array[0]]]
//for (prev, current) in zip(array, array.dropFirst()) {
//    if prev == current {
//        result[result.endIndex - 1].append(current)
//    } else {
//        result.append([current])
//    }
//}
//print(result, result.count)

extension Array {
    func split(where condition: (Element, Element) -> Bool) -> [[Element]] {
        var result: [[Element]] = self.isEmpty ? [] : [[self[0]]]
        for (previous, current) in zip(self, self.dropFirst()) {
            if condition(previous, current) {
                result.append([current])
            } else {
                result[result.endIndex - 1].append(current)
            }
        }
        return result
    }
    
    func some() {
         
    }
    
}
let finalSplit = array.split(where: !=) //array.split(where: {$0 != $1})
print(finalSplit.compactMap({$0.map({$0})}))

let name = "Amir Alio Akbari this my freind"
