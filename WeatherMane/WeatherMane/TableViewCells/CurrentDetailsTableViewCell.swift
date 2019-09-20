//
//  CurrentDetailsTableViewCell.swift
//  WeatherMane
//
//  Created by Sean Bukich on 9/20/19.
//  Copyright © 2019 Sean Bukich. All rights reserved.
//

import UIKit

class CurrentDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nearestStormLabel: UILabel!
    @IBOutlet weak var looksLikeLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    var currentWeather: CurrentWeather?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func styleCell() {
        guard let c = currentWeather else {
            return
        }
        
        nearestStormLabel.text = "\(c.nearestStormDistance) mi."
        looksLikeLabel.text = "\(c.summary)"
        windSpeedLabel.text = "\(c.windSpeed) mph"

    }

}
