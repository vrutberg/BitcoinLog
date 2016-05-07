//
//  DetailViewController.swift
//  BitcoinLog
//
//  Created by Viktor Rutberg on 30/10/15.
//  Copyright © 2015 Viktor Rutberg. All rights reserved.
//

import UIKit
import BitcoinApi

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
                self.presentAlert("Favourite removed")
                FavouritesService.removeFavourite(item.tickerSymbol)
            } else {
                self.presentAlert("Favourite added")
                FavouritesService.addFavourite(item.tickerSymbol)
            }
        }
    }

    private func presentAlert(text: String) {
        let alert = UIAlertController(title: text, message: nil, preferredStyle: .Alert)

        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))

        self.presentViewController(alert, animated: true, completion: nil)
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

