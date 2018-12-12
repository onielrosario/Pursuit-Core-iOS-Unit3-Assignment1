//
//  StockDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Oniel Rosario on 12/11/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {
    @IBOutlet weak var stockDate: UILabel!
    @IBOutlet weak var stockImage: UIImageView!
    @IBOutlet weak var stockOpeningLabel: UILabel!
    @IBOutlet weak var stockClosingLabel: UILabel!
    var stockInfo: AppleStocks!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockDate.text = "Date: \(stockInfo.date)"
        stockOpeningLabel.text = "Stock open: \(stockInfo.open)"
        stockClosingLabel.text = "Stock close: \(stockInfo.close)"
        stockImage.image = image
    }
  

}
