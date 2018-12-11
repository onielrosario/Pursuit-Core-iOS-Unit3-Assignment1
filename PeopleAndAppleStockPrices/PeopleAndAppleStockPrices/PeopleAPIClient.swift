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
        guard let url = URL.init(string: "https://randomuser.me/api/?results=50") else {
            completionHandler(nil, .badURL("url failed"))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completionHandler(nil, .badData(error))
            }
            if let data = data {
                do {
                    let peopleImageurl = UIImage.init(data: data)
               
                
                } catch {
                    completionHandler(nil, .badDecoding(error))
                }
                
                
            }
            
            
            
        }.resume()
        
        
    }
    
    
    static func getImage() {
        
        
    }
    
}
