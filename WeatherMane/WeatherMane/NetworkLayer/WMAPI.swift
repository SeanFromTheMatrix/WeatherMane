//
//  WMAPI.swift
//  WeatherMane
//
//  Created by Sean Bukich on 9/29/19.
//  Copyright © 2019 Sean Bukich. All rights reserved.
//

import Foundation

struct WMAPI {
    
    // Generic function to handle API calls
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
            
            // Do->Try->Catch
            do {
                // Decode the forecast
                let object = try JSONDecoder().decode(T.self, from: d)
                // Use 'object' to update VC in completion handler
                completion(object)
            } catch {
                print(error, "error")
            }
        // Resume task
        }.resume()
    }
}
