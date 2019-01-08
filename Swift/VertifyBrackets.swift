//
//  VertifyBrackets.swift
//  Algorithms
//
//  Created by 储诚鹏 on 2019/1/8.
//  Copyright © 2019 储诚鹏. All rights reserved.
//

import UIKit

class VertifyBrackets {
    func vertify(_ str: String) -> Bool {
        var lefts = [Character]()
        
        func pop(_ char: Character) -> Bool {
            guard let left = lefts.last else { return false }
            if "()[]{}".contains("\(left)\(char)") {
                lefts.remove(at: lefts.count - 1)
            }
            else { return false }
            return true
        }
        
        func extractedFunc(_ char: Character) {
            if let left = lefts.last {
                let lastIdx = "([{".firstIndex(of: left)!
                let idx = "([{".firstIndex(of: char)!
                guard idx < lastIdx else { return false }
            }
            lefts.append(char)
        }
        
        func push(_ char: Character) -> Bool {
            extractedFunc(char)
            return true
        }
        
        for char in str {
            if "({[".contains(char) {
                if !push(char) {
                    return false
                }
            }
            else if ")]}".contains(char) {
                if !pop(char) {
                    return false
                }
            }
        }
        return true
    }
}
