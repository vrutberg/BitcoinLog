//
//  BitcoinRate.swift
//  BitcoinLog
//
//  Created by Viktor Rutberg on 30/10/15.
//  Copyright © 2015 Viktor Rutberg. All rights reserved.
//

import Foundation

public class BitcoinRate {
    var tickerSymbol: String = ""
    var timestamp: String = ""
    
    var avg24h: Float = 0
    var ask: Float = 0
    var bid: Float = 0
    var last: Float = 0
    
    var volume_btc: Float = 0
    var volume_percent: Float = 0
    
    init(tickerSymbol: String, timestamp: String, avg24h: Float, ask: Float, bid: Float, last: Float, volume_btc: Float, volume_percent: Float) {
        self.tickerSymbol = tickerSymbol
        self.timestamp = timestamp
        
        self.ask = ask
        self.bid = bid
        self.last = last
        
        self.volume_btc = volume_btc
        self.volume_percent = volume_percent
    }
}