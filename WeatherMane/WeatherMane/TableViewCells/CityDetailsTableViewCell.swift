//
//  CityDetailsTableViewCell.swift
//  WeatherMane
//
//  Created by Sean Bukich on 9/18/19.
//  Copyright © 2019 Sean Bukich. All rights reserved.
//

import UIKit

class CityDetailsTableViewCell: UITableViewCell {
    
    // Outlets for the UIElements
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityTemp: UILabel!
    @IBOutlet weak var cityVibe: UILabel!
    
    // Datasource for cell
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
        cityVibe.text = "\(h.summary)"
        cityName.text = "\(NSDate(timeIntervalSince1970: TimeInterval(h.time)))"
        cityTemp.text = "\(h.temperature)°F"
        
    }

}
