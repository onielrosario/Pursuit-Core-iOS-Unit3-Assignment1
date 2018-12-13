//
//  PeopleAPIClient.swift
//  PeopleAndAppleStockPrices
//
//  Created by Oniel Rosario on 12/10/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit


enum PeopleError {
    case badURL(String)
    case badData(Error)
    case badDecoding(Error)
    
}



final class PeopleAPI {
    
    static func getPeople(searchName: String, completionHandler: @escaping([ResultsWrapper]?, PeopleError?) -> Void ) {
        guard let url = URL.init(string: "https://randomuser.me/api/?inc=gender,\(searchName),nat") else {
            completionHandler(nil, .badURL("url failed"))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completionHandler(nil, .badData(error))
            }
            if let data = data {
                do {
                    let peopleData = try JSONDecoder().decode(UserInfo.self, from: data)
                    completionHandler(peopleData.results, nil)
                } catch {
                    completionHandler(nil, .badDecoding(error))
                }
            }
        }.resume()
    }
    
    static func getImage(url: String) -> UIImage? {
        guard let imageURL = URL.init(string: url) else { return nil}
        guard let data = try? Data.init(contentsOf: imageURL) else {return nil}
        let image = UIImage.init(data: data)
        return image
    }
    
}
