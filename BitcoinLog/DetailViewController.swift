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
    
    var shouldShowFavouriteButton = true {
        didSet {
            if shouldShowFavouriteButton == false {
                favouriteButton.hidden = true
            }
        }
    }
    
    @IBOutlet weak var favouriteButton: UIButton!

    @IBAction func favouiteButtonTouched(sender: UIButton) {
        if let item = self.detailItem {
            if FavouritesService.isFavourite(item.tickerSymbol) {
                FavouritesService.removeFavourite(item.tickerSymbol)
            } else {
                FavouritesService.addFavourite(item.tickerSymbol)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "tableViewSegue" {
            let detailTableViewController = segue.destinationViewController as! DetailTableViewController
            detailTableViewController.ticker = self.detailItem!.tickerSymbol
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

