//
//  CityDetailsTableViewCell.swift
//  WeatherMane
//
//  Created by Sean Bukich on 9/18/19.
//  Copyright © 2019 Sean Bukich. All rights reserved.
//

import UIKit

class CityDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityTemp: UILabel!
    @IBOutlet weak var cityVibe: UILabel!
    
    var hourlyData: HourlyData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func styleCell() {
        
        guard let h = hourlyData else {
            return
        }
        
        cityVibe.text = "\(h.summary)"
        cityName.text = "\(NSDate(timeIntervalSince1970: TimeInterval(h.time)))"
        cityTemp.text = "\(h.temperature)°F"
        
    }

}
