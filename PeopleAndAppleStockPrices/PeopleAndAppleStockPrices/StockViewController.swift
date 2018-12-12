//
//  StockViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Oniel Rosario on 12/11/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

//var appleStock = [AppleStocks]()

class StockViewController: UIViewController {
    @IBOutlet weak var stockTableView: UITableView!
    var allStock = [AppleStocks]() {
        didSet {
            DispatchQueue.main.async {
                self.stockTableView.reloadData()
            }
        }
    }
   
    override func viewDidLoad() {
        stockTableView.dataSource = self
        stockTableView.delegate = self
        super.viewDidLoad()
        title = "Stock Prices"
   loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       guard let destination = segue.destination as? StockDetailViewController,
        let selectedStock = stockTableView.indexPathForSelectedRow else { return }
        let stockCell = allStock[selectedStock.row]
        //let stockToSend = stockCell[selectedStock.row]
     destination.stockInfo = stockCell
        if stockCell.change > 0 {
            destination.image = UIImage.init(named: "thumbUp")
            destination.view.backgroundColor = .green
        } else {
            destination.image = UIImage.init(named: "thumbsDown")
             destination.view.backgroundColor = .red
        }
      
    }
    func loadData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let myUrl = URL.init(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myUrl) {
                do {
                    self.allStock = try JSONDecoder().decode([AppleStocks].self, from: data)
                } catch {
                    print(error)
                }
                return
            }
        }
    }
}



extension StockViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allStock.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = stockTableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath) as? StockTableViewCell else { return UITableViewCell()}
    let indexPath = allStock[indexPath.row]
      cell.stockOpening.text = "\(indexPath.date)"
       cell.stockClosing.text = "\(indexPath.open)"
        if indexPath.change > 0 {
            cell.backgroundColor = .green
            cell.stockImage.image = UIImage.init(named: "thumbUp")
        } else {
            cell.backgroundColor = .red
             cell.stockImage.image = UIImage.init(named: "thumbsDown")
        }
    return cell
    }
}

extension StockViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
