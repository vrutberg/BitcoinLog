//
//  BitcoinApi.swift
//  BitcoinLog
//
//  Created by Viktor Rutberg on 30/10/15.
//  Copyright © 2015 Viktor Rutberg. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public class BitcoinApi {
    public func fetchAll(callback: ([BitcoinRate]) -> Void) {
        Alamofire.request(.GET, "https://api.bitcoinaverage.com/ticker/global/all").responseJSON { response in
            let json = JSON(response.result.value!).dictionary
            var arrayOfBitcoinRateObjects: [BitcoinRate] = []
            
            for (key, subJson):(String, JSON) in json! {
                if key != "timestamp" {
                    arrayOfBitcoinRateObjects.append(BitcoinRate(
                    tickerSymbol: key,
                        timestamp: subJson["timestamp"].stringValue,
                        avg24h: subJson["24h_avg"].floatValue,
                        ask: subJson["ask"].floatValue,
                        bid: subJson["bid"].floatValue,
                        last: subJson["last"].floatValue,
                        volume_btc: subJson["volume_btc"].floatValue,
                        volume_percent: subJson["volume_percent"].floatValue))
                }
            }
            
            arrayOfBitcoinRateObjects.sortInPlace({ $0.tickerSymbol < $1.tickerSymbol })
            callback(arrayOfBitcoinRateObjects)
        }
    }
}