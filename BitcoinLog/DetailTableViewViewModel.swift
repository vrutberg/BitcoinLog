//
//  DetailTableViewController.swift
//  BitcoinLog
//
//  Created by Viktor Rutberg on 09/12/15.
//  Copyright © 2015 Viktor Rutberg. All rights reserved.
//

import Foundation
import PromiseKit
import BitcoinApi

class DetailTableViewViewModel {
    private let api: BitcoinApi
    private let ticker: String

    var rate: BitcoinRate

    var ask: String {
        return String(rate.ask) + " " + rate.tickerSymbol
    }

    var bid: String {
        return String(rate.bid) + " " + rate.tickerSymbol
    }

    var last: String {
        return String(rate.last) + " " + rate.tickerSymbol
    }

    var volume: String {
        return String(rate.volume_btc) + " BTC"
    }

    var volumePercent: String {
        return String(rate.volume_percent) + " %"
    }

    init(ticker: String, api: BitcoinApi = BitcoinApiFactory.get()) {
        self.api = api
        self.ticker = ticker

        self.rate = BitcoinRate()
    }

    func fetchData() -> Promise<Void> {
        return api.fetchSingleRate(self.ticker).then({ rate in
            self.rate = rate
        }).asVoid()
    }
}
