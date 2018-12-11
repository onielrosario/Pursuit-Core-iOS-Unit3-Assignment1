//
//  People.swift
//  PeopleAndAppleStockPrices
//
//  Created by Oniel Rosario on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct UserInfo: Codable {
    let results: [ResultsWrapper]
}
struct ResultsWrapper: Codable {
    let name: NameWrapper
    let location: LocationWrapper
    let picture: Picture
}
struct NameWrapper: Codable {
    let first: String
    let last: String
}
struct LocationWrapper: Codable {
    let city: String
    let state: String
}
struct Picture: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}


