//
//  MasterViewController.swift
//  BitcoinLog
//
//  Created by Viktor Rutberg on 30/10/15.
//  Copyright © 2015 Viktor Rutberg. All rights reserved.
//

import UIKit
import BitcoinApi

class MasterViewController: UITableViewController {
    private let api = BitcoinApiFactory.get()
    
    var rateList: BitcoinRateList = BitcoinRateList(rates: []) {
        didSet {
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: "updateData", forControlEvents: UIControlEvents.ValueChanged)
        
        self.updateData()
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    func updateData() {
        api.fetchAllRates().then({ bitcoinRateList in
            self.rateList = bitcoinRateList
        })
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = self.rateList.bitcoinRates[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                
                controller.detailItem = object
                controller.navigationItem.title = object.tickerSymbol
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
        return self.rateList.bitcoinRates.count
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! BitcoinValueTableViewCell
        let object = self.rateList.bitcoinRates[indexPath.row]
        
        cell.tickerLabel.text = object.tickerSymbol
        cell.valueLabel.text = String(object.last)
        
        return cell
    }
}

