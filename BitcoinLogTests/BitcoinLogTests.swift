//
//  BitcoinLogTests.swift
//  BitcoinLogTests
//
//  Created by Viktor Rutberg on 30/10/15.
//  Copyright © 2015 Viktor Rutberg. All rights reserved.
//

import XCTest
import PromiseKit

@testable import BitcoinLog

class BitcoinLogTests: XCTestCase {
    func testDetailViewModelFormatsDataCorrectly() {
        let expectation = expectationWithDescription("wat")
        let vm = DetailTableViewViewModel(ticker: "SNORLAX", api: BitcoinApiMock())
    
        vm.fetchData().then({ rate in
            XCTAssertEqual(vm.ask, "330.49 SNORLAX")
            XCTAssertEqual(vm.bid, "340.41 SNORLAX")
            XCTAssertEqual(vm.last, "335.12 SNORLAX")
            XCTAssertEqual(vm.volume, "1234.56 BTC")
            XCTAssertEqual(vm.volumePercent, "12.34 %")
            
            expectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(100, handler: nil)
    }
}
