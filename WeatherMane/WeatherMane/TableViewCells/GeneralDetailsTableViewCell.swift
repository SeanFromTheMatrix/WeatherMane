//
//  GeneralDetailsTableViewCell.swift
//  WeatherMane
//
//  Created by Sean Bukich on 9/20/19.
//  Copyright © 2019 Sean Bukich. All rights reserved.
//

import UIKit

class GeneralDetailsTableViewCell: UITableViewCell {
    
    // Outlets for UIElements
    @IBOutlet weak var latitudeLongitudeLabel: UILabel!
    
    // Give cell a dataSource
    var dataSource: Forecast?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    // Function called in cellForRow to set the values
    func styleCell() {
        
        // Make sure there is data in the cell
        guard let d = dataSource else {
            return
        }
        
        //Set the values to each corresponding outlet
        latitudeLongitudeLabel.text = "\(d.latitude)/\(d.longitude)"
    }

}
