//
//  AlgorithmsSwiftTests.swift
//  AlgorithmsSwiftTests
//
//  Created by 储诚鹏 on 2018/9/17.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

import XCTest

class AlgorithmsSwiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test2_3_4Sum() {
        testFromIndex()
    }
    
    func testHashFunctions() {
        let str = "abcdefgffwewfewjfiewjfeowfjewiofjewiofjewiojfewiojfifjief"
        HashFunctions.sdbm(str)
        HashFunctions.djb2(str)
        print("system--🐯🐯", str.hashValue)
    }
    
}
