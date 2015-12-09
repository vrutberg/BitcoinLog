//
//  BitcoinApiMock.swift
//  BitcoinLog
//
//  Created by Viktor Rutberg on 09/12/15.
//  Copyright © 2015 Viktor Rutberg. All rights reserved.
//

import Foundation
import PromiseKit
@testable import BitcoinLog

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