//
//  HashFunctions.swift
//  Algorithms
//
//  Created by 储诚鹏 on 2018/9/17.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

import UIKit

class HashFunctions {
    
    @discardableResult
    static func sdbm(_ str: String) -> Int {
        var hash = 0
        for char in str.unicodeScalars {
            hash = Int(char.value) &+ (hash << 6) &+ (hash << 16) &- hash
        }
        print("🐯🐯--", hash)
        hash = hash & 0x7FFFFFFF
        print("🐯--", hash)
        return hash
    }
    
    @discardableResult
    static func djb2(_ str: String) -> Int64 {
        var hash: Int64 = 5381
        for char in str.unicodeScalars {
            hash = ((hash << 5) &+ hash) &+ Int64(char.value)
        }
        print("🐯🐯🐯", hash)
        return hash
    }

}
