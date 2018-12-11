//
//  DetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Oniel Rosario on 12/11/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var peoplePicture: UIImageView!
    @IBOutlet weak var peopleName: UILabel!
    @IBOutlet weak var peopleLocation: UILabel!
    @IBOutlet weak var peopleEmail: UILabel!
    var people: ResultsWrapper!
    var name: String!
    var location: String!
    var email: String!
    var image: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        peoplePicture.image = image
        peopleName.text = name.capitalized
        peopleLocation.text = location.capitalized
        peopleEmail.text = email
    }
    
}
