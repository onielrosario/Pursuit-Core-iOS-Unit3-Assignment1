//
//  StockAPIClient.swift
//  PeopleAndAppleStockPrices
//
//  Created by Oniel Rosario on 12/12/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit



final class StockAPI {

    static func getStocks(urlString: String ) {
    let urlStr = "https://api.iextrading.com/1.0/stock/aapl/chart/2y"
        guard let url = URL(string: urlStr) else {
            print("bad url: \(urlStr)")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else if let data = data {
                do {
                 let stocks = try JSONDecoder().decode(AppleStocks.self, from: data)
                   
                } catch {
                    
                }
            }
        
        }.resume()
    }


    static func getStockImage(url: String) -> UIImage? {
        guard let imageURL = URL.init(string: url) else { return nil}
        guard let data = try? Data.init(contentsOf: imageURL) else {return nil}
        let image = UIImage.init(data: data)
        return image
    }


}
