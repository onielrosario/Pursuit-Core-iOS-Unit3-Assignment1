//
//  StockAPIClient.swift
//  PeopleAndAppleStockPrices
//
//  Created by Oniel Rosario on 12/12/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

final class StockAPI {
    static func getStockImage(url: String) -> UIImage? {
        guard let imageURL = URL.init(string: url) else { return nil}
        guard let data = try? Data.init(contentsOf: imageURL) else {return nil}
        let image = UIImage.init(data: data)
        return image
    }
}
