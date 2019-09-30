//
//  HourlyDetailsTableViewCell.swift
//  WeatherMane
//
//  Created by Sean Bukich on 9/20/19.
//  Copyright © 2019 Sean Bukich. All rights reserved.
//

import UIKit

class HourlyDetailsTableViewCell: UITableViewCell {
    
    // Create outlets for the different UIElements
    @IBOutlet weak var cloudCoverageLabel: UILabel!
    @IBOutlet weak var looksLikeLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    // Create dataSource for the cell
    var hourlyData: HourlyData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // Style the cell as desired
    func styleCell() {
        
        // Make sure we have data
        guard let h = hourlyData else {
            return
        }
        
        // Set the cloud coverage
        cloudCoverageLabel.text = "\(h.cloudCover)%"
        // Set the simple weather summary
        looksLikeLabel.text = "\(h.summary)"
        //Set the windspeed 
        windSpeedLabel.text = "\(h.windSpeed) mph"
     
        
    }

}
