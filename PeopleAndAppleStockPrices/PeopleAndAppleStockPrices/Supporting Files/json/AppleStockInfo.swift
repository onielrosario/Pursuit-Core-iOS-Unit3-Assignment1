//
//  AppleStockInfo.swift
//  PeopleAndAppleStockPrices
//
//  Created by Oniel Rosario on 12/11/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation


struct AppleStockInfo: Codable {
    let appleStocksInfo: [AppleStocks]
}

struct AppleStocks: Codable {
    let date: String
    let open: Double
    let close: Double
    let change: Double
}
