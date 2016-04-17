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


protocol BitcoinApi {
    func fetchMultipleRates(tickers: String...) -> Promise<BitcoinRateList>
    func fetchMultipleRates(ticker: [String]) -> Promise<BitcoinRateList>

    func fetchAllRates() -> Promise<BitcoinRateList>

    func fetchSingleRate(ticker: String) -> Promise<BitcoinRate>
}

class BitcoinApiImpl: BitcoinApi {
    private init() {}

    class func create() -> BitcoinApi {
        return BitcoinApiImpl()
    }

    func fetchMultipleRates(tickers: String...) -> Promise<BitcoinRateList> {
        return fetchMultipleRates(tickers)
    }
    
    func fetchMultipleRates(tickers: [String]) -> Promise<BitcoinRateList> {
        let deferred = Promise<BitcoinRateList>.pendingPromise()
        var promises: [Promise<BitcoinRate>] = []
            
        for ticker in tickers {
            promises.append(self.fetchSingleRate(ticker))
        }
            
        when(promises).then({ rates in
            deferred.fulfill(BitcoinRateList(rates: rates))
        })
        
        return deferred.promise
    }
    
    func fetchAllRates() -> Promise<BitcoinRateList> {
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
    
    func fetchSingleRate(ticker: String) -> Promise<BitcoinRate> {
        let deferred = Promise<BitcoinRate>.pendingPromise()
        let route = BitcoinRequestRouter.SingleRate(ticker)
        
        Alamofire.request(route.method, route.URLRequest).responseObject() { (response: Response<BitcoinRate, NSError>) -> Void in
            if response.result.isSuccess {
                if var type = response.result.value {
                    type.tickerSymbol = ticker
                    deferred.fulfill(type)
                } else {
                    deferred.reject(response.result.error!)
                }
            }
        }
        
        return deferred.promise
    }
}