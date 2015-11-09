//
//  DetailViewController.swift
//  BitcoinLog
//
//  Created by Viktor Rutberg on 30/10/15.
//  Copyright © 2015 Viktor Rutberg. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var detailItem: BitcoinRate?

    @IBAction func favouiteButtonTouched(sender: UIButton) {
        if let item = self.detailItem {
            if FavouriteService.isFavourite(item.tickerSymbol) {
                print("Removing favourite \(item.tickerSymbol)...")
                FavouriteService.removeFavourite(item.tickerSymbol)
            } else {
                print("Adding favourite \(item.tickerSymbol)...")
                FavouriteService.addFavourite(item.tickerSymbol)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "tableViewSegue" {
            let detailTableViewController = segue.destinationViewController as! DetailTableViewController
            detailTableViewController.rate = self.detailItem
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

