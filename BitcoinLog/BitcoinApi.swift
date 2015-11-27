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
    
    public static func fetchAllDecoded<T : ResponseObjectSerializable>(callback: (value: T) -> Void) {
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