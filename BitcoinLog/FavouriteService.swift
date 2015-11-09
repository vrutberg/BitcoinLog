//
//  FavouriteService.swift
//  BitcoinLog
//
//  Created by Viktor Rutberg on 09/11/15.
//  Copyright © 2015 Viktor Rutberg. All rights reserved.
//

import UIKit

class FavouriteService {
    private static let key = "favouriteExchangeRates"
    
    static func getAll() -> [String] {
        return NSUserDefaults.standardUserDefaults().objectForKey(key) as? [String] ?? [String]()
    }
    
    static func isFavourite(ticker: String) -> Bool {
        return self.getAll().contains(ticker)
    }
    
    static func addFavourite(ticker: String) {
        var favourites = self.getAll()
        
        if !favourites.contains(ticker) {
            favourites.append(ticker)
                
            let userDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults.setObject(favourites, forKey: self.key)
            userDefaults.synchronize()
        }
    }
    
    static func removeFavourite(ticker: String) {
        let favourites = self.getAll()
        let filteredFavourites = favourites.filter() { $0 != ticker }

        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(filteredFavourites, forKey: self.key)
        userDefaults.synchronize()
    }
}