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
    public static func fetchAllRates<T : ResponseObjectSerializable>(callback: (value: T) -> Void) {
        self.makeApiCall(BitcoinRequestRouter.AllRates, callback: callback)
    }
    
    public static func fetchSingleRate<T : ResponseObjectSerializable>(ticker: String, callback: (value: T) -> Void) {
        self.makeApiCall(BitcoinRequestRouter.SingleRate(ticker), callback: callback)
    }
    
    private static func makeApiCall<T: ResponseObjectSerializable>(route: BitcoinRequestRouter, callback: (value: T) -> Void) {
        Alamofire.request(route.method, route.URLRequest).responseObject() { (response: Response<T,NSError>) -> Void in
            if response.result.isSuccess {
                if let type = response.result.value {
                    callback(value: type)
                }
            }
            
        }
    }
}