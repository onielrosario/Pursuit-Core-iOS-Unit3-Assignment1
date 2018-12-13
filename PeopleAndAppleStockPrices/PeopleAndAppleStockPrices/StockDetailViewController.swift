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
    
    func configDetailViewController() {
        if stockInfo.close > stockInfo.open {
            stockImage.image = UIImage.init(named: "thumbUp")
            view.backgroundColor = .green
        } else {
            stockImage.image = UIImage.init(named: "thumbsDown")
            view.backgroundColor = .red
        }
        stockDate.text = "Date: \(stockInfo.date)"
        stockOpeningLabel.text = "Stock open: \(String(format: "%.2f", stockInfo.open))"
        stockClosingLabel.text = "Stock close: \(String(format: "%.2f", stockInfo.close))"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      configDetailViewController()
    }
  

}
