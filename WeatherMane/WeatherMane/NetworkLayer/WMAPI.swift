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
        
        // Initiate API Call
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Check for a dataSource
            guard let d = data else {
                return
            }
            
            do {
                // Decode the forecast
                let object = try JSONDecoder().decode(T.self, from: d)
                completion(object)
            } catch {
                print(error, "error")
            }
        }.resume()
    }
}
