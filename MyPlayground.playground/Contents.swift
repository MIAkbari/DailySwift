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
    func custoMMap<T>(_ transform: (Element) -> T) -> [T] {
        var result:[T] = []
        result.reserveCapacity(count)
        for index in self {
            result.append(transform(index))
        }
        return result
    }
}

sqaurd.custoMMap({$0})
sqaurd.compactMap({$0})
