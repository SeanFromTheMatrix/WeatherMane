//
//  HourlyDetailsTableViewCell.swift
//  WeatherMane
//
//  Created by Sean Bukich on 9/20/19.
//  Copyright © 2019 Sean Bukich. All rights reserved.
//

import UIKit

class HourlyDetailsTableViewCell: UITableViewCell {

    // Outlets for UIElements
    @IBOutlet weak var cloudCoverageLabel: UILabel!
    @IBOutlet weak var looksLikeLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var feelsLikeTempLabel: UILabel!
    
    // Give cell a dataSource
    var hourlyData: HourlyData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // Function called in cellForRow to set the values
    func styleCell() {
        
        // Make sure there is data in the cell
        guard let h = hourlyData else {
            return
        }
        
        //Set the values to each corresponding outlet
        cloudCoverageLabel.text = "\(h.cloudCover)%"
        tempLabel.text = "\(h.temperature)°F"
        feelsLikeTempLabel.text = "\(h.apparentTemperature)°F"
        looksLikeLabel.text = "\(h.summary)"
        windSpeedLabel.text = "\(h.windSpeed) mph"
     
        
    }

}
