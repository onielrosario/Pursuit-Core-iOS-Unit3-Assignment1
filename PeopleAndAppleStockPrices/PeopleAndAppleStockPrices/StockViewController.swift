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
    
    var allStock = [AppleStocks]().sorted{ $0.year < $1.year } {
        didSet {
            DispatchQueue.main.async {
                self.getAllDates()
                self.stockTableView.reloadData()
            }
        }
    }
    
    var allDates: [(month: String, year: String)] = [].sorted{$0.year < $1.year}
    
    
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
        let sortedStocks = allStock.sorted{$0.year < $1.year }
        let stockCell = sortedStocks[selectedStock.row]
        destination.stockInfo = stockCell
        if stockCell.open > stockCell.close {
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
                    self.allStock = try JSONDecoder().decode([AppleStocks].self, from: data).sorted{$0.year < $1.year }
                } catch {
                    print(error)
                }
                return
            }
        }
        
    }
    
    private func filterStockDate(date: (month: String, year: String)) -> [AppleStocks] {
        let results = allStock.filter { stock in
            let stockDate = getDateMonth(dateString: stock.date)
            return stockDate.year == date.year && stockDate.month == date.month
        }
        return results
    }
    
    
    func getAllDates() {
        var allDateSet: Set<String> = Set()
        allStock.forEach {
            let formattedDate = getDateMonth(dateString: $0.date)
            allDateSet.insert("\(formattedDate.year)-\(formattedDate.month)")
        }
        
        allDates = allDateSet.sorted{ $0 < $1 }.map{ getDateMonth(dateString: $0) }
    }
    
    func getDateMonth(dateString: String) -> (month: String, year: String) {
        let components = dateString.components(separatedBy: "-")
        return (components[1], components[0])
    }
    
}
    
    
    
    extension StockViewController: UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            return allDates.count
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let sections = filterStockDate(date: allDates[section]).sorted{$0.year < $1.year}
            
            return sections.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = stockTableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath) as? StockTableViewCell else { return UITableViewCell()}
            let sortedStock = filterStockDate(date: allDates[indexPath.section]).sorted {
                $0.month < $1.month}
            let stock = sortedStock[indexPath.row]
            cell.stockOpening.text = "\(stock.date)"
            cell.stockClosing.text = "\(stock.open)"
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
            let date = allDates[section]
            return "Year \(date.year) Month \(date.month)"
        }
    }
    
    extension StockViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80
        }
}
