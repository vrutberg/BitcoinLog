//
//  DetailTableViewController.swift
//  BitcoinLog
//
//  Created by Viktor Rutberg on 05/11/15.
//  Copyright © 2015 Viktor Rutberg. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    @IBOutlet weak var bidValueLevel: UILabel!
    @IBOutlet weak var lastValueLabel: UILabel!
    @IBOutlet weak var volumeValueLabel: UILabel!
    @IBOutlet weak var askValueLabel: UILabel!
    @IBOutlet weak var volumePercentValueLabel: UILabel!

    var rate: BitcoinRate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: "updateData", forControlEvents: UIControlEvents.ValueChanged)
        
        self.configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateData() {
        BitcoinApi.fetchSingleRate((rate?.tickerSymbol!)!).then({ rate in
            self.rate = rate
            self.configureView()
            self.refreshControl?.endRefreshing()
        })
    }
    
    func configureView() {
        if let detail = self.rate {
            askValueLabel.text = String(detail.ask) + " " + detail.tickerSymbol!
            bidValueLevel.text = String(detail.bid) + " " + detail.tickerSymbol!
            lastValueLabel.text = String(detail.last) + " " + detail.tickerSymbol!
            
            volumeValueLabel.text = String(detail.volume_btc) + " BTC"
            volumePercentValueLabel.text = String(detail.volume_percent) + " %"
        }
    }
}