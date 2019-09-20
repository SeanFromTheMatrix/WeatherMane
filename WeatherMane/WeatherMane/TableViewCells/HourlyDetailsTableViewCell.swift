//
//  HourlyDetailsTableViewCell.swift
//  WeatherMane
//
//  Created by Sean Bukich on 9/20/19.
//  Copyright © 2019 Sean Bukich. All rights reserved.
//

import UIKit

class HourlyDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var cloudCoverageLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    var hourlyData: HourlyData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func styleCell() {
        
        guard let h = hourlyData else {
            return
        }
        
        cloudCoverageLabel.text = "\(h.cloudCover)%"
        humidityLabel.text = "\(h.humidity)%"
        windSpeedLabel.text = "\(h.windSpeed) mph"
     
        
    }

}
