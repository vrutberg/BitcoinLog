//
//  DetailTableViewController.swift
//  BitcoinLog
//
//  Created by Viktor Rutberg on 05/11/15.
//  Copyright © 2015 Viktor Rutberg. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    let api = BitcoinApiImpl.create()

    var vm: DetailTableViewViewModel?
    var ticker: String?

    @IBOutlet weak var bidValueLevel: UILabel!
    @IBOutlet weak var lastValueLabel: UILabel!
    @IBOutlet weak var volumeValueLabel: UILabel!
    @IBOutlet weak var askValueLabel: UILabel!
    @IBOutlet weak var volumePercentValueLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: "updateData", forControlEvents: UIControlEvents.ValueChanged)

        self.vm = DetailTableViewViewModel(ticker: self.ticker!)
        self.updateData()
    }

    func updateData() {
        vm!.fetchData().then({
            self.configureView()
            self.refreshControl?.endRefreshing()
        })
    }
    
    func configureView() {
        askValueLabel.text = vm!.ask
        bidValueLevel.text = vm!.bid
        lastValueLabel.text = vm!.last

        volumeValueLabel.text = vm!.volume
        volumePercentValueLabel.text = vm!.volumePercent
    }
}