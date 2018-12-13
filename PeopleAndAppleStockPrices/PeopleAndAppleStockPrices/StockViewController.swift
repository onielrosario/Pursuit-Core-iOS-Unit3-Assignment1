//
//  StockViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Oniel Rosario on 12/11/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockViewController: UIViewController {
    @IBOutlet weak var stockTableView: UITableView!
    
    var allStock = [AppleStocks]() {
        didSet {
            DispatchQueue.main.async {
                self.stockTableView.reloadData()
            }
        }
    }
    var sectionNames = [String]()
    
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockTableView.dataSource = self
        stockTableView.delegate = self
        title = "Stock Prices"
        loadData()
        fillSectionNames()
    }
    
    func stockBySection(section: Int) -> [AppleStocks] {
        return allStock.filter{$0.sectionName == sectionNames[section]}
    }
    
    func fillSectionNames() {
        for stock in allStock {
            if !sectionNames.contains(stock.sectionName) {
                sectionNames.append(stock.sectionName)
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? StockDetailViewController,
            let selectedStock = stockTableView.indexPathForSelectedRow else { return }
        //guard let stockCell = sender as? StockTableViewCell else {return}
        let stockThisSection = stockBySection(section: selectedStock.section)
        let thisStock = stockThisSection[selectedStock.row]
        destination.stockInfo = thisStock
       
    }
    func loadData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let myUrl = URL.init(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myUrl) {
                do {
                    self.allStock = try JSONDecoder().decode([AppleStocks].self, from: data).sorted{$0.date < $1.date }
                } catch {
                    print(error)
                }
                return
            }
        }
    }
}
    
    
    
    extension StockViewController: UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            return sectionNames.count
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               return stockBySection(section: section).count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = stockTableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath) as? StockTableViewCell else { return UITableViewCell()}
            let stocksInSection = stockBySection(section: indexPath.section)
            let stock = stocksInSection[indexPath.row]
            cell.stockOpening.text = "\(stock.date)"
            cell.stockClosing.text = "\(String(format: "%.2f", stock.open))"
            if stock.close > stock.open {
                cell.backgroundColor = .green
                cell.stockImage.image = UIImage.init(named: "thumbUp")
            } else {
                cell.backgroundColor = .red
                cell.stockImage.image = UIImage.init(named: "thumbsDown")
            }
            return cell
        }
        
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            let thisSection = sectionNames[section]
            var sum = 0.0
            let stocksInSection = allStock.filter{$0.sectionName == thisSection }
            for stock in stocksInSection {
                sum += stock.open
            }
            let average = sum / Double(stocksInSection.count)
            return thisSection + " " + "Average: $\(String(format: "%.2f", average))"
        }
    }
    
    extension StockViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80
        }
}
