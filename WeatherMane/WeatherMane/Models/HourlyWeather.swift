//
//  HourlyWeather.swift
//  WeatherMane
//
//  Created by Sean Bukich on 9/18/19.
//  Copyright © 2019 Sean Bukich. All rights reserved.
//

import Foundation

struct HourlyWeather: Decodable {
    let summary: String?
    let icon: String?
    let data: [HourlyData]?

}
