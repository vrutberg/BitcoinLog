//
//  BitcoinRate.swift
//  BitcoinLog
//
//  Created by Viktor Rutberg on 30/10/15.
//  Copyright © 2015 Viktor Rutberg. All rights reserved.
//

import Foundation

public class BitcoinRate {
    let tickerSymbol: String
    let timestamp: String
    
    let avg24h: Float
    let ask: Float
    let bid: Float
    let last: Float
    
    let volume_btc: Float
    let volume_percent: Float
    
    init(tickerSymbol: String, timestamp: String, avg24h: Float, ask: Float, bid: Float,
         last: Float, volume_btc: Float, volume_percent: Float) {
        self.tickerSymbol = tickerSymbol
        self.timestamp = timestamp

        self.avg24h = 0
        self.ask = ask
        self.bid = bid
        self.last = last
        
        self.volume_btc = volume_btc
        self.volume_percent = volume_percent
    }
}