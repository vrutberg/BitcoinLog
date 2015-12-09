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
    
    /*
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    */
}

class BitcoinApiMock: BitcoinApi {
    func fetchSingleRate(ticker: String) -> Promise<BitcoinRate> {
        let rate = BitcoinRate(
            tickerSymbol: ticker,
            timestamp: "2015-12-09 22:03:44",
            avg24h: 333.0,
            ask: 330.49,
            bid: 340.41,
            last: 335.12,
            volume_btc: 1234.56,
            volume_percent: 12.34
        )
        
        return Promise<BitcoinRate>(rate)
    }
    
    func fetchAllRates() -> Promise<BitcoinRateList> {
        return Promise<BitcoinRateList>(BitcoinRateList(rates: []))
    }
    
    func fetchMultipleRates(ticker: [String]) -> Promise<BitcoinRateList> {
        return self.fetchAllRates()
    }
    
    func fetchMultipleRates(tickers: String...) -> Promise<BitcoinRateList> {
        return self.fetchMultipleRates(tickers)
    }
}