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
import PromiseKit

public class BitcoinApi {
    
    public static func fetchMultipleRates(tickers: String...) -> Promise<BitcoinRateList> {
        return fetchMultipleRates(tickers)
    }
    
    public static func fetchMultipleRates(tickers: [String]) -> Promise<BitcoinRateList> {
        let deferred = Promise<BitcoinRateList>.pendingPromise()
        var promises: [Promise<BitcoinRate>] = []
            
        for ticker in tickers {
            promises.append(self.fetchSingleRateWithPromise(ticker))
        }
            
        when(promises).then({ rates in
            deferred.fulfill(BitcoinRateList(rates: rates))
        })
        
        return deferred.promise
    }
    
    public static func fetchAllRatesWithPromise() -> Promise<BitcoinRateList> {
        let deferred = Promise<BitcoinRateList>.pendingPromise()
        let route = BitcoinRequestRouter.AllRates
        
        Alamofire.request(route.method, route.URLRequest).responseObject() { (response: Response<BitcoinRateList, NSError>) -> Void in
            if response.result.isSuccess {
                if let type = response.result.value {
                    deferred.fulfill(type)
                } else {
                    deferred.reject(response.result.error!)
                }
            }
        }
        
        return deferred.promise
    }
    
    public static func fetchSingleRateWithPromise(ticker: String) -> Promise<BitcoinRate> {
        let deferred = Promise<BitcoinRate>.pendingPromise()
        let route = BitcoinRequestRouter.SingleRate(ticker)
        
        Alamofire.request(route.method, route.URLRequest).responseObject() { (response: Response<BitcoinRate, NSError>) -> Void in
            if response.result.isSuccess {
                if let type = response.result.value {
                    type.tickerSymbol = ticker
                    deferred.fulfill(type)
                } else {
                    deferred.reject(response.result.error!)
                }
            }
        }
        
        return deferred.promise
    }
    
    
    public static func fetchAllRates<T : ResponseObjectSerializable>(callback: (value: T) -> Void) {
        self.makeApiCall(BitcoinRequestRouter.AllRates, callback: callback)
    }
    
    public static func fetchSingleRate<T : ResponseObjectSerializable>(ticker: String, callback: (value: T) -> Void) {
        self.makeApiCall(BitcoinRequestRouter.SingleRate(ticker), callback: callback)
    }
    
    private static func makeApiCall<T: ResponseObjectSerializable>(route: BitcoinRequestRouter, callback: (value: T) -> Void) {
        Alamofire.request(route.method, route.URLRequest).responseObject() { (response: Response<T, NSError>) -> Void in
            if response.result.isSuccess {
                if let type = response.result.value {
                    callback(value: type)
                }
            }
        }
    }
}