//
//  BitcoinRequestRouter.swift
//  BitcoinLog
//
//  Created by Viktor Rutberg on 01/12/15.
//  Copyright © 2015 Viktor Rutberg. All rights reserved.
//

import Foundation
import Alamofire

enum BitcoinRequestRouter: URLRequestConvertible {
    static let baseURL = "https://api.bitcoinaverage.com/ticker/global"
    
    case AllRates
    case SingleRate(String)
    
    var method: Alamofire.Method {
        switch self {
            case .AllRates:
                return .GET
            case .SingleRate:
                return .GET
        }
    }
    
    var URLRequest: NSMutableURLRequest {
        let path: String = {
            switch self {
                case .AllRates():
                    return "/all"
                case .SingleRate(let ticker):
                    return "/\(ticker)"
            }
        }()
        
        let URL = NSURL(string: BitcoinRequestRouter.baseURL)
        let URLRequest = NSURLRequest(URL: URL!.URLByAppendingPathComponent(path))
        let encoding = Alamofire.ParameterEncoding.URL
        
        return encoding.encode(URLRequest, parameters: [String : AnyObject]()).0
    }
}