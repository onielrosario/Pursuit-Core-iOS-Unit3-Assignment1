//
//  StockTableViewCell.swift
//  PeopleAndAppleStockPrices
//
//  Created by Oniel Rosario on 12/11/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockTableViewCell: UITableViewCell {
    @IBOutlet weak var stockImage: UIImageView!
    
    @IBOutlet weak var stockOpening: UILabel!
    
    @IBOutlet weak var stockClosing: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
