//
//  BitcoinRate.swift
//  BitcoinLog
//
//  Created by Viktor Rutberg on 30/10/15.
//  Copyright © 2015 Viktor Rutberg. All rights reserved.
//

import Foundation
import SwiftyJSON

public class BitcoinRate : ResponseObjectSerializable {
    var tickerSymbol: String?
    let timestamp: String
    
    let avg24h: Float
    let ask: Float
    let bid: Float
    let last: Float
    
    let volume_btc: Float
    let volume_percent: Float
    
    @objc required public convenience init?(representation: AnyObject) {
        let json = JSON(representation)
        self.init(tickerSymbol: nil, json: json)
    }
    
    init(tickerSymbol: String?, json: JSON) {
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