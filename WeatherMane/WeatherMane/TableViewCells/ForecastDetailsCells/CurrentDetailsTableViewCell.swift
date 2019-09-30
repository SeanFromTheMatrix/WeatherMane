//
//  CurrentDetailsTableViewCell.swift
//  WeatherMane
//
//  Created by Sean Bukich on 9/20/19.
//  Copyright © 2019 Sean Bukich. All rights reserved.
//

import UIKit

class CurrentDetailsTableViewCell: UITableViewCell {
    
    // Create outlets for the different UIElements
    @IBOutlet weak var nearestStormLabel: UILabel!
    @IBOutlet weak var looksLikeLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    // Create dataSource for the cell
    var currentWeather: CurrentWeather?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // Style the cell as desired
    func styleCell() {
        
        // Make sure we have data
        guard let c = currentWeather else {
            return
        }
        
        // Set the nearest storm distance
        nearestStormLabel.text = "\(c.nearestStormDistance) mi."
        // Set the simple weather summary
        looksLikeLabel.text = "\(c.summary)"
        // Set the wind speed
        windSpeedLabel.text = "\(c.windSpeed) mph"

    }

}
