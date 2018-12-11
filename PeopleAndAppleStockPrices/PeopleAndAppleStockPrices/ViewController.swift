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
  var people = [ResultsWrapper]()

    
    override func viewDidLoad() {
        title = "Random People"
     peopleTableView.dataSource = self
    super.viewDidLoad()
    loadData()
        dump(people)
  }

    func loadData() {
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            let myURL = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myURL) {
                do {
                   let people = try JSONDecoder().decode(UserInfo.self,from: data)
                    self.people = people.results
                } catch {
                    print(error)
                }
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = peopleTableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath)
        let peopleinfo = people[indexPath.row]
        cell.textLabel?.text = "\(peopleinfo.name.first) \(peopleinfo.name.last)"
        cell.detailTextLabel?.text = peopleinfo.location.city
        guard let imageUrl = URL.init(string: peopleinfo.picture.thumbnail) else { return UITableViewCell() }
        do {
            let data = try Data.init(contentsOf: (imageUrl))
            cell.imageView?.image = UIImage.init(data: data)
        } catch {
            print(error)
        }
       return cell
    }
}

