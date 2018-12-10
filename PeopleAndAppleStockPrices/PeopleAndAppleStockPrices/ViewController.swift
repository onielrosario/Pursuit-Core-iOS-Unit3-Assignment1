//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var peopleTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
  var people = [People]()

    
    override func viewDidLoad() {
    super.viewDidLoad()
    loadData()
  }

    func loadData() {
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            let myURL = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myURL) {
                do {
                    self.people = try JSONDecoder().decode([People].self, from: data)
                } catch {
                    print(error)
                }
            }
        }
    }
}

