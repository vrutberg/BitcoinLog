//
//  FavouritesViewController.swift
//  BitcoinLog
//
//  Created by Viktor Rutberg on 09/11/15.
//  Copyright © 2015 Viktor Rutberg. All rights reserved.
//

import UIKit

class FavouritesViewController: UITableViewController {
    var rates = [BitcoinRate]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.populateData()
    }
    
    func populateData() {
        BitcoinApi.fetchMultipleRates(FavouritesService.getAll()).then({ rateList in
            self.rates = rateList.bitcoinRates
            self.tableView.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = rates[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! FavouriteDetailViewController
                
                controller.ticker = object.tickerSymbol!
/*                controller.navigationItem.title = object.tickerSymbol*/
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rates.count
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FavouriteCell", forIndexPath: indexPath) as! FavouritesTableViewCell
        
        // TODO: fix this
        cell.tickerLabel.text = rates[indexPath.row].tickerSymbol ?? "nil"
        
        return cell
    }
}

