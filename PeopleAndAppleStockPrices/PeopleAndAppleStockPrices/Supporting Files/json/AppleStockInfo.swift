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
    var year: Int {
        let components = date.components(separatedBy: "-")
        return Int(components[0])!
    }
    var month: Int {
        let components = date.components(separatedBy: "-")
        return Int(components[1])!
    }
    var sectionName: String {
       var dateComponents = date.components(separatedBy: "-")
        let year = dateComponents[0]
        let month = dateComponents[1]
        return "\(MonthsDict[month]!) - \(year)"
    }
     private let MonthsDict = [
        "01":"January",
        "02":"February",
        "03":"March",
        "04":"April",
        "05":"May",
        "06":"June",
        "07":"July",
        "08":"August",
        "09":"September",
        "10":"October",
        "11":"November",
        "12":"December"
    ]
}
