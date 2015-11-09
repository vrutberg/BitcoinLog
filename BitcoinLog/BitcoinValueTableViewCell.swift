//
//  BitcoinValueTableViewCell.swift
//  BitcoinLog
//
//  Created by Viktor Rutberg on 30/10/15.
//  Copyright © 2015 Viktor Rutberg. All rights reserved.
//

import UIKit

class BitcoinValueTableViewCell: UITableViewCell {

    var ticker: String = ""
    var value: Float = 0
    
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var tickerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
