//
//  CityDetailsTableViewCell.swift
//  WeatherMane
//
//  Created by Sean Bukich on 9/18/19.
//  Copyright © 2019 Sean Bukich. All rights reserved.
//

import UIKit

class CityDetailsTableViewCell: UITableViewCell {
    
    // Create outlets for the different UIElements
    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityTemp: UILabel!
    @IBOutlet weak var cityVibe: UILabel!
    
    // Create dataSource for the cell
    var forecast: Forecast?
    
    // Create a variable to recieve the cell context from the previous viewControllers cellForRow
    var cellLocation: ListingCity?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    // Style the cell as desired
    func styleCell() {
        
        // Make sure we have data
        guard let f = forecast else {
            return
        }
        
        // Set the time zone/location name
        cityName.text = f.timeZone
        // Set the temperatures value
        cityTemp.text = "\(Int(f.currentWeather.temperature))°F"
        // Set the simple weather summary
        cityVibe.text = f.currentWeather.summary
        
        // Depending on the cell context, show the specified image
        if cellLocation == .LA {
            cityImage.image = UIImage(named: "losAngelesImage")
        } else {
            cityImage.image = UIImage(named: "newYorkImage")
        }
        
    }
    
    // Add a rounded corner radius to the imageView
    override func draw(_ rect: CGRect) {
        
        // Set corner radius to half of the width and height
        cityImage.layer.cornerRadius = 60
        
        // Confine to the bounds of the imageView
        cityImage.clipsToBounds = true
    }

}
