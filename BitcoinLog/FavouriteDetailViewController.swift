//
//  FavouriteDetailViewController.swift
//  BitcoinLog
//
//  Created by Viktor Rutberg on 20/11/15.
//  Copyright © 2015 Viktor Rutberg. All rights reserved.
//

import UIKit

class FavouriteDetailViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    var ticker: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ticker = "SEK"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        BitcoinApi.fetchSingleRate(ticker!) { (value: BitcoinRate) -> Void in
            self.label.text = String(value.bid)
        }
    }
}
