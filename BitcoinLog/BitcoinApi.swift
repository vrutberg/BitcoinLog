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

    private static let baseUrl = "https://api.bitcoinaverage.com/ticker/global"

    public static func fetchAll(callback: ([BitcoinRate]) -> Void) {
        Alamofire.request(.GET, "\(self.baseUrl)/all").responseJSON { response in
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


    public static func fetchSingle(ticker: String, callback: (BitcoinRate) -> Void) {
        Alamofire.request(.GET, "\(self.baseUrl)/\(ticker)").responseJSON { response in
            let json = JSON(response.result.value!)

            let rate = BitcoinRate(
                tickerSymbol: ticker,
                timestamp: json["timestamp"].stringValue,
                avg24h: json["24h_avg"].floatValue,
                ask: json["ask"].floatValue,
                bid: json["bid"].floatValue,
                last: json["last"].floatValue,
                volume_btc: json["volume_btc"].floatValue,
                volume_percent: json["volume_percent"].floatValue)

            callback(rate)
        }
    }
    
    public static func fetchAllDecoded<T : ResponseObjectSerializable>(ticker: String, callback: (value: T) -> Void) {
        Alamofire.request(.GET, "\(self.baseUrl)/all").responseObject() { (response: Response<T,NSError>) -> Void in
            if response.result.isSuccess {
                if let type = response.result.value {
                    callback(value: type)
                }
            }
            
        }
    }
    
    public static func fetchSingleDecoded<T : ResponseObjectSerializable>(ticker: String, callback: (value: T) -> Void) {
        Alamofire.request(.GET, "\(self.baseUrl)/\(ticker)").responseObject() { (response: Response<T,NSError>) -> Void in
            if response.result.isSuccess {
                if let type = response.result.value {
                    callback(value: type)
                }
            }

        }
    }
}