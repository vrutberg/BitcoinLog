//
//  MasterViewController.swift
//  BitcoinLog
//
//  Created by Viktor Rutberg on 30/10/15.
//  Copyright © 2015 Viktor Rutberg. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [BitcoinRate]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: "updateData", forControlEvents: UIControlEvents.ValueChanged)
        
        self.updateData()
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    func updateData() {
        BitcoinApi.fetchAllDecoded(self.populateData)
    }
    
    func populateData(objects: BitcoinRateList) {
        self.objects = objects.bitcoinRates
        self.refreshControl?.endRefreshing()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
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
        return objects.count
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! BitcoinValueTableViewCell
        let object = objects[indexPath.row]
        
        cell.tickerLabel.text = object.tickerSymbol
        cell.valueLabel.text = String(object.last)
        
        return cell
    }
}

