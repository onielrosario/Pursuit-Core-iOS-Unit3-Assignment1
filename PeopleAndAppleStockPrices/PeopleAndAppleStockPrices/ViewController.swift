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
    var people = [ResultsWrapper]() {
        didSet {
            DispatchQueue.main.async {
                self.peopleTableView.reloadData()
            }
        }
    }

    
    override func viewDidLoad() {
        title = "Random People"
     peopleTableView.dataSource = self
        searchBar.delegate = self
    super.viewDidLoad()
    
    loadData()
//        xrdump(people)
  }

    func loadData() {
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            let myURL = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myURL) {
                do {
                   let people = try JSONDecoder().decode(UserInfo.self,from: data)
                    self.people = people.results
                    self.people.sort{$0.name.first < $1.name.first}
                } catch {
                    print(error)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? DetailViewController,
        let selectedIndexpath = peopleTableView.indexPathForSelectedRow else { return }
        let peopleToSend = people[selectedIndexpath.row]
        destination.people = peopleToSend
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = peopleTableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath)
        let peopleinfo = people[indexPath.row]
        cell.textLabel?.text = "\(peopleinfo.name.first) \(peopleinfo.name.last)".capitalized
        cell.detailTextLabel?.text = "\(peopleinfo.location.city), \(peopleinfo.location.state)"
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

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
    }
    
}
