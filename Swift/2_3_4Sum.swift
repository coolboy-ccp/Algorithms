//
//  2_3_4Sum.swift
//  Algorithms
//
//  Created by 储诚鹏 on 2018/9/17.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

import UIKit

extension Collection where Element: Equatable {
    func formUnique(after idx: inout Index) {
        var prev = idx
        repeat {
            prev = idx
            formIndex(after: &idx)
        } while idx < endIndex && self[prev] == self[idx]
    }
}

extension BidirectionalCollection where Element: Equatable {
    func formUnique(before idx: inout Index) {
        var prev = idx
        repeat {
            prev = idx
            formIndex(before: &idx)
        } while idx > startIndex && self[prev] == self[idx]
    }
}

class Sum2_3_4 {
    static func twoSum<T: BidirectionalCollection>(_ collection: T, target: T.Element) -> [[T.Element]] where T.Element: Numeric & Comparable {
        let sorted = collection.sorted()
        var ret = [[T.Element]]()
        var l = sorted.startIndex
        var r = sorted.index(before: sorted.endIndex)
        while l < r {
            let sum  = sorted[l] + sorted[r]
            if sum == target {
                ret.append([sorted[l], sorted[r]])
                sorted.formUnique(before: &r)
                sorted.formUnique(after: &l)
            }
            else if sum < target {
                sorted.formUnique(after: &l)
            }
            else {
                sorted.formUnique(before: &r)
            }
        }
        return ret
    }
    
    static func threeSum<T: BidirectionalCollection>(_ collection: T, target: T.Element) -> [[T.Element]] where T.Element: Numeric & Comparable {
        let sorted = collection.sorted()
        var ret = [[T.Element]]()
        var l = sorted.startIndex
        while l < sorted.endIndex {
            defer { sorted.formUnique(after: &l) }
            var m = sorted.index(after: l)
            var r = sorted.index(before: sorted.endIndex)
            while m < r {
                let sum = sorted[l] + sorted[m] + sorted[r]
                if sum == target {
                    ret.append([sorted[l], sorted[m], sorted[r]])
                    sorted.formUnique(after: &m)
                    sorted.formIndex(before: &r)
                }
                else if sum < target {
                    sorted.formUnique(after: &m)
                }
                else {
                    sorted.formUnique(before: &r)
                }
            }
        }
        return ret
    }
    
    static func fourSum<T: BidirectionalCollection>(_ collection: T, target: T.Element) -> [[T.Element]] where T.Element: Numeric & Comparable {
        let sorted = collection.sorted()
        var ret = [[T.Element]]()
        var l = sorted.startIndex
        Four: while l < sorted.endIndex {
            defer { sorted.formUnique(after: &l) }
            var ml = sorted.index(after: l)
            Three: while ml < sorted.endIndex {
                defer { sorted.formIndex(after: &ml) }
                var m = sorted.index(after: ml)
                var r = sorted.index(before: sorted.endIndex)
                Two: while m < r {
                    let sum = sorted[l] + sorted[ml] + sorted[m] + sorted[r]
                    if sum == target {
                        ret.append([sorted[l], sorted[ml], sorted[m], sorted[r]])
                        sorted.formUnique(before: &r)
                        sorted.formUnique(after: &m)
                    }
                    else if sum < target {
                        sorted.formUnique(after: &m)
                    }
                    else {
                        sorted.formUnique(before: &r)
                    }
                }
            }
        }
        return ret
    }
}



func testFromIndex() {
    let array = [1,-2,3,4,2,0,-1,-1,5,-5]
    let _2Sum = Sum2_3_4.twoSum(array, target: 0)
    let _3Sum = Sum2_3_4.threeSum(array, target: 0)
    let _4Sum = Sum2_3_4.fourSum(array, target: 0)
    print("2sum🌹🌹🌹", _2Sum)
    print("3sum🌹🌹🌹", _3Sum)
    print("4sum🌹🌹🌹", _4Sum)
}
