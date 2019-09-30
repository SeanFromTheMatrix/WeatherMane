//
//  GeneralDetailsTableViewCell.swift
//  WeatherMane
//
//  Created by Sean Bukich on 9/20/19.
//  Copyright © 2019 Sean Bukich. All rights reserved.
//

import UIKit

class GeneralDetailsTableViewCell: UITableViewCell {
    
    // Create outlets for the different UIElements
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var latitudeLongitudeLabel: UILabel!
    
    // Create dataSource for the cell
    var dataSource: Forecast?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    // Style the cell as desired
    func styleCell() {
        
        // Make sure we have data
        guard let d = dataSource else {
            return
        }
        
        // Set the location
        cityName.text = d.timeZone
        // Set the latitude and longitude
        latitudeLongitudeLabel.text = "\(d.latitude)/\(d.longitude)"
    }

}
