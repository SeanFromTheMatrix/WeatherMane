//
//  WMAPI.swift
//  WeatherMane
//
//  Created by Sean Bukich on 9/29/19.
//  Copyright © 2019 Sean Bukich. All rights reserved.
//

import Foundation

struct WMAPI {
    
    static func fetchGenericForecasts<T: Decodable>(urlString: String, completion: @escaping (T) -> ()) {

        // Turn the string into a URL for the URL session
        guard let url = URL(string: urlString) else {
            return
        }

        // Initiate API call
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            //check for a data source
            guard let d = data else {
                return
            }

            do {
                // decode the Forecast
                let object = try JSONDecoder().decode(T.self, from: d)
                
                completion(object)
            } catch {
                
                // if there is an error, print it
                print("error", error)
            }

        }.resume()
    }
    
}

