//
//  HourlyData.swift
//  WeatherMane
//
//  Created by Sean Bukich on 9/18/19.
//  Copyright © 2019 Sean Bukich. All rights reserved.
//

import Foundation

struct HourlyData: Decodable {
    let time: Int
    let summary: String
    let icon: String
    let precipIntensity: Double
    let precipProbability: Double
    let temperature: Double
    let apparentTemperature: Double
    let dewPoint: Double
    let humidity: Double
    let pressure: Double
    let windSpeed: Double
    let windGust: Double
    let windBearing: Double
    let cloudCover: Double
    let uvIndex: Double
    let visibility: Double
    let ozone: Double
    
}
