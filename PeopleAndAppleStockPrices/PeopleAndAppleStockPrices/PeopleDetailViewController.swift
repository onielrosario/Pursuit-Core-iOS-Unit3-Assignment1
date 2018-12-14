//
//  DetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Oniel Rosario on 12/11/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class PeopleDetailViewController: UIViewController {
    @IBOutlet weak var peoplePicture: UIImageView!
    @IBOutlet weak var peopleName: UILabel!
    @IBOutlet weak var peopleLocation: UILabel!
    @IBOutlet weak var peopleEmail: UILabel!
    var people: ResultsWrapper!
    var image: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        peoplePicture.image = image
        peopleName.text = "\(people.name.first) \(people.name.last)".capitalized
        peopleLocation.text = "\(people.location.city), \(people.location.state)".capitalized
        peopleEmail.text = people.email
    }
}
