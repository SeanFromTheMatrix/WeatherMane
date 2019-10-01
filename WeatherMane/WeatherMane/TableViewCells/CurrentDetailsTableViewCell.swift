//
//  CurrentDetailsTableViewCell.swift
//  WeatherMane
//
//  Created by Sean Bukich on 9/20/19.
//  Copyright © 2019 Sean Bukich. All rights reserved.
//

import UIKit

class CurrentDetailsTableViewCell: UITableViewCell {
    
    // Outlets for UIElements
    @IBOutlet weak var nearestStormLabel: UILabel!
    @IBOutlet weak var looksLikeLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    // Give cell a dataSource
    var currentWeather: CurrentWeather?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // Function called in cellForRow to set the values
    func styleCell() {
        
        // Make sure there is data in the cell
        guard let c = currentWeather else {
            return
        }
        
        //Set the values to each corresponding outlet
        nearestStormLabel.text = "\(c.nearestStormDistance) mi."
        looksLikeLabel.text = "\(c.summary)"
        windSpeedLabel.text = "\(c.windSpeed) mph"

    }

}
