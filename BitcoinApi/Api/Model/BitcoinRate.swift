//
//  BitcoinRate.swift
//  BitcoinLog
//
//  Created by Viktor Rutberg on 30/10/15.
//  Copyright © 2015 Viktor Rutberg. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct BitcoinRate: ResponseObjectSerializable {
    public var tickerSymbol: String
    public let timestamp: String
    
    public let avg24h: Float
    public let ask: Float
    public let bid: Float
    public let last: Float
    
    public let volume_btc: Float
    public let volume_percent: Float
    
    init(representation: AnyObject) {
        let json = JSON(representation)
        self.init(tickerSymbol: "-", json: json)
    }

    public init() {
        self.tickerSymbol = "-"
        self.timestamp = "-"

        self.avg24h = 0.0
        self.ask = 0.0
        self.bid = 0.0
        self.last = 0.0
        self.volume_btc = 0.0
        self.volume_percent = 0.0
    }
    
    init(tickerSymbol: String, json: JSON) {
        self.tickerSymbol = tickerSymbol
        self.timestamp = json["timestamp"].stringValue
        self.avg24h = json["24h_avg"].floatValue
        self.ask = json["ask"].floatValue
        self.bid = json["bid"].floatValue
        self.last = json["last"].floatValue
        self.volume_btc = json["volume_btc"].floatValue
        self.volume_percent = json["volume_percent"].floatValue
    }
    
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