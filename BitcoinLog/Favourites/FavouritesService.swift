//
//  FavouriteService.swift
//  BitcoinLog
//
//  Created by Viktor Rutberg on 09/11/15.
//  Copyright © 2015 Viktor Rutberg. All rights reserved.
//

import UIKit

protocol FavouritesService {
    func getAll() -> [String]
    func isFavourite(ticker: String) -> Bool
    func addFavourite(ticker: String)
    func removeFavourite(ticker: String)
}

class FavouritesServiceFactory {
    private static let instance = FavouritesServiceImpl()

    static func get() -> FavouritesService {
        return instance
    }
}

class FavouritesServiceImpl: FavouritesService {
    private let STORAGE_KEY = "favouriteExchangeRates"

    private func getUserDefaults() -> NSUserDefaults {
        return NSUserDefaults.standardUserDefaults()
    }

    func getAll() -> [String] {
        return getUserDefaults().objectForKey(STORAGE_KEY) as? [String] ?? [String]()
    }

    func isFavourite(ticker: String) -> Bool {
        return getAll().contains(ticker)
    }
    
    func addFavourite(ticker: String) {
        var favourites = getAll()
        
        if !favourites.contains(ticker) {
            favourites.append(ticker)
                
            let userDefaults = getUserDefaults()
            userDefaults.setObject(favourites, forKey: STORAGE_KEY)
            userDefaults.synchronize()
        }
    }
    
    func removeFavourite(ticker: String) {
        let favourites = getAll()
        let filteredFavourites = favourites.filter() { $0 != ticker }

        let userDefaults = getUserDefaults()
        userDefaults.setObject(filteredFavourites, forKey: STORAGE_KEY)
        userDefaults.synchronize()
    }
}