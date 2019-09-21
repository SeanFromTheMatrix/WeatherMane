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
    @IBOutlet weak var looksLikeLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var feelsLikeTempLabel: UILabel!
    
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
        tempLabel.text = "\(h.temperature)°F"
        feelsLikeTempLabel.text = "\(h.apparentTemperature)°F"
        looksLikeLabel.text = "\(h.summary)"
        windSpeedLabel.text = "\(h.windSpeed) mph"
     
        
    }

}
