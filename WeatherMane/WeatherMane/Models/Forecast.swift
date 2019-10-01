//
//  ForeCast.swift
//  WeatherMane
//
//  Created by Sean Bukich on 9/18/19.
//  Copyright © 2019 Sean Bukich. All rights reserved.
//

import Foundation

// Data model to store values for entire forecast JSON
struct Forecast: Decodable {

    let latitude: Float
    let longitude: Float
    let timeZone: String
    let currentWeather: CurrentWeather
    let hourlyWeather: HourlyWeather
    
    // Add coding keys to read the JSON keys
    enum CodingKeys: String, CodingKey {
        
        case latitude, longitude
        case timeZone = "timezone"
        case currentWeather = "currently", hourlyWeather = "hourly"
        
    }
    
}
