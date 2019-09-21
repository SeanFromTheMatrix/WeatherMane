//
//  CityDetailsTableViewCell.swift
//  WeatherMane
//
//  Created by Sean Bukich on 9/18/19.
//  Copyright © 2019 Sean Bukich. All rights reserved.
//

import UIKit

class CityDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityTemp: UILabel!
    @IBOutlet weak var cityVibe: UILabel!
    
    var forecast: Forecast?
    var hourlyData: HourlyData?
    var currentWeather: CurrentWeather?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    //
    func setData(hourlyData: HourlyData?,  currentWeather: CurrentWeather?) {
        self.hourlyData = hourlyData
        self.currentWeather = currentWeather
    }
    
    func styleCell() {
        
        guard let f = forecast else {
            return
        }
        
        cityName.text = f.timeZone
        cityTemp.text = "\(Int(f.currentWeather.temperature))°F"
        cityVibe.text = f.currentWeather.summary
        
    }
    
    override func draw(_ rect: CGRect) {
        cityImage.layer.cornerRadius = 60
        cityImage.clipsToBounds = true
    }

}
