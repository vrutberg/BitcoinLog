//
//  BitconRateList.swift
//  BitcoinLog
//
//  Created by Viktor Rutberg on 27/11/15.
//  Copyright © 2015 Viktor Rutberg. All rights reserved.
//

import Foundation
import SwiftyJSON

public class BitcoinRateList : ResponseObjectSerializable {
    let bitcoinRates: [BitcoinRate]
    
    @objc required public init?(representation: AnyObject) {
        let json = JSON(representation)
        var arrayOfBitcoinRateObjects: [BitcoinRate] = []
        
        for (key, subJson) : (String, JSON) in json {
            if key != "timestamp" {
                arrayOfBitcoinRateObjects.append(BitcoinRate(tickerSymbol: key, json: subJson))
            }
        }
        
        bitcoinRates = arrayOfBitcoinRateObjects.sort { $0.tickerSymbol < $1.tickerSymbol }
    }
    
    public init(rates: [BitcoinRate]) {
        bitcoinRates = rates.sort { $0.tickerSymbol < $1.tickerSymbol }
    }
}