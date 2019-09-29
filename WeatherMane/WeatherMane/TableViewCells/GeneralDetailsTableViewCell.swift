//
//  GeneralDetailsTableViewCell.swift
//  WeatherMane
//
//  Created by Sean Bukich on 9/20/19.
//  Copyright © 2019 Sean Bukich. All rights reserved.
//

import UIKit

class GeneralDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var latitudeLongitudeLabel: UILabel!
    
    var dataSource: Forecast?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    func styleCell() {
        guard let d = dataSource else {
            return
        }
        
        cityName.text = d.timeZone
        latitudeLongitudeLabel.text = "\(d.latitude)/\(d.longitude)"
    }

}
