//
//  StockViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Oniel Rosario on 12/11/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var appleStock = [AppleStocks]()
    
    override func viewDidLoad() {
        tableView.dataSource = self
        super.viewDidLoad()
   loadData()
        
    }
    
    
}


func loadData() {
    if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
       let myUrl = URL.init(fileURLWithPath: path)
        if let data = try? Data(contentsOf: myUrl) {
            do {
               let stocks = try JSONDecoder().decode(AppleStocks.self, from: data)
          
                
            } catch {
                print(error)
            }
            return
        }
    }
}

extension StockViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appleStock.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    
    
    
    
}
