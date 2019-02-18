//
//  FullPermutation.swift
//  Algorithms
//
//  Created by 储诚鹏 on 2019/2/18.
//  Copyright © 2019 储诚鹏. All rights reserved.
//

import UIKit

class FullPermutation<T> {
    private var fpArray = [[T]]()
    private let array: [T]
    
    init(array: [T]) {
        self.array = array
    }
    
    private func swap(array: inout [T], a: Int, b: Int){
        let bElement = array[b]
        let aElement = array.remove(at: a)
        array.insert(bElement, at: a)
        array.remove(at: b)
        array.insert(aElement, at: b)
    }
    
    private func perm(array: inout [T], start: Int, count: Int) {
        if start == count - 1 {
            fpArray.append(array)
            return
        }
        for i in start ..< count {
            swap(array: &array, a: start, b: i)
            perm(array: &array, start: start + 1, count: count)
            swap(array: &array, a: start, b: i)
        }
    }
    
    func fullPermutation()->[[T]] {
        var marr = self.array
        perm(array: &marr, start: 0, count: marr.count)
        return fpArray
    }
}

extension Array {
    func fullPermutation() -> [[Element]] {
        return FullPermutation<Element>(array: self).fullPermutation()
    }
}

