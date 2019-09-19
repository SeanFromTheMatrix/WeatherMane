//
//  CurrentWeather.swift
//  WeatherMane
//
//  Created by Sean Bukich on 9/18/19.
//  Copyright © 2019 Sean Bukich. All rights reserved.
//

import Foundation

struct CurrentWeather: Decodable {
    let time: Int
    let summary: String
    let icon: String
    let nearestStormDistance: Double
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
    
    enum CodingKeys: String, CodingKey {
        case time = "time"
        case summary = "summary"
        case icon = "icon"
        case nearestStormDistance = "nearestStormDistance"
        case precipIntensity = "precipIntensity"
        case precipProbability = "precipProbability"
        case temperature = "temperature"
        case apparentTemperature = "apparentTemperature"
        case dewPoint = "dewPoint"
        case humidity = "humidity"
        case pressure = "pressure"
        case windSpeed = "windSpeed"
        case windGust = "windGust"
        case windBearing = "windBearing"
        case cloudCover = "cloudCover"
        case uvIndex = "uvIndex"
        case visibility = "visibility"
        case ozone = "ozone"

    }
}
