//
//  ForecastDetailsViewController.swift
//  WeatherMane
//
//  Created by Sean Bukich on 9/19/19.
//  Copyright © 2019 Sean Bukich. All rights reserved.
//

import UIKit

// Create enumeration for the different section on the viewController
enum ForeCastSections: Int, CaseIterable {
    case general = 0
    case hourly = 1
    case current = 2
}

class ForecastDetailsViewController: UIViewController {

    // Create outlets for the tableView and the other UIElements
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var goBackTapArea: UIView!
    
    // Create dataSources
    var generalData: Forecast?
    var currentData: CurrentWeather?
    var hourlyData: HourlyData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set delegate and dataSource of the tableView to the viewController
        tableView.delegate = self
        tableView.dataSource = self
        
        // Call method that adds tapGestures
        setUpGestures()
        
    }
    
    // Method to create gestureRecognizers
    func setUpGestures() {
        
        // Create tapGesture to be added to the view(goBackTapArea)
        let goBackTap = UITapGestureRecognizer(target: self, action: #selector(backTapAction(_:)))
        goBackTapArea.addGestureRecognizer(goBackTap)
    }
    
    // Method to be called on the tapGesture
    @objc func backTapAction(_ t: UITapGestureRecognizer) {
        
        // Navigate to the previous viewController
        self.navigationController?.popViewController(animated: true)
    }

}

extension ForecastDetailsViewController: UITableViewDelegate {
    
    // Set heights for each row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // Check for data, else return 0 height
        guard let _ = generalData else {
            return 0
        }
        
        // switch on the indexPath/ForeCastSections to determine each cells height
        switch indexPath.section {
            
        case ForeCastSections.general.rawValue:
            return 100
            
        case ForeCastSections.current.rawValue:
            return 150
            
        case ForeCastSections.hourly.rawValue:
            return 300
            
        default:
            return 0
            
        }
    }
}

extension ForecastDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        // Check to make sure there is data
        guard let _ = generalData else {
            return 0
        }
        
        // Return the number of casese in the ForeCastSections enum
        return ForeCastSections.allCases.count
    }
    
    // Determine the number of rows in each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Check to make sure there is data
        guard let _ = generalData else {
            return 0
        }
        
        // switch on ForeCastSections to determine the number of rows
        switch section {
        case ForeCastSections.general.rawValue:
            return 1
        case ForeCastSections.current.rawValue:
            return 1
        case ForeCastSections.hourly.rawValue:
            return 1
        default:
            return 0

        }
    }
    
    // Customize the headerView
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        // Create variable to access UIElements on the desired view
        let view = Bundle.main.loadNibNamed("ForecastDetailHeaderView", owner: self, options: nil)![0] as? ForecastDetailHeaderView
        
        // Check to make sure there is data
        guard let _ = generalData else {
            return UIView()
        }
        
        // switch on ForeCastSections to set values on each headerView
        switch section {
            
        case ForeCastSections.general.rawValue:
            view?.forecastTypeLabel.text = "Location"
            return view
            
        case ForeCastSections.current.rawValue:
            view?.forecastTypeLabel.text = "Current Forecast"
            return view
            
        case ForeCastSections.hourly.rawValue:
            view?.forecastTypeLabel.text = "Forecast For Selected Date/Time"
            return view
            
        default:
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        
        // Check to make sure there is data
        guard let _ = generalData else {
            return 0
        }
        
        // Switch on ForeCastSections to determine the height for each header
        switch section {
            
        case ForeCastSections.general.rawValue:
            return 50
            
        case ForeCastSections.current.rawValue:
            return 50
            
        case ForeCastSections.hourly.rawValue:
            return 50
            
        default:
            return 50
            
        }
        
    }

    // Pass data and customize each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create cell to use of there is no data
        let c = UITableViewCell()
        let noData: String = "Error getting forecasts"
        
        c.textLabel?.text = noData
        c.textLabel?.textColor = UIColor.black
        c.textLabel?.textAlignment = .center
        c.textLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
                
        // Check to make sure there is data to pass to each cell
        // NOTE: try refactoring this to only need 1 data source(generalData has the entire forecast)
        guard let gd = generalData,
            let cd = currentData,
            let hd = hourlyData else {
            return c
        }
        
        var cell = UITableViewCell()
        
        // Switch on each indexPath/ForeCastSections to determine which cell is being accessed
        switch indexPath.section {
            
        case ForeCastSections.general.rawValue:
            let nc = tableView.dequeueReusableCell(withIdentifier: "GeneralDetailsTableViewCell", for: indexPath) as! GeneralDetailsTableViewCell
            
            // Pass data to the cell's dataSource
            nc.dataSource = gd
            // Set all values according to the outlets and corresponding data
            nc.styleCell()
            cell = nc
            
        case ForeCastSections.current.rawValue:
            let nc = tableView.dequeueReusableCell(withIdentifier: "CurrentDetailsTableViewCell", for: indexPath) as! CurrentDetailsTableViewCell
            
            // Pass data to the cell's dataSource
            nc.currentWeather = cd
            // Set all values according to the outlets and corresponding data
            nc.styleCell()

            cell = nc
            
        case ForeCastSections.hourly.rawValue:
            let nc = tableView.dequeueReusableCell(withIdentifier: "HourlyDetailsTableViewCell", for: indexPath) as! HourlyDetailsTableViewCell
            
            // Pass data to the cell's dataSource
            nc.hourlyData = hd
            // Set all values according to the outlets and corresponding data
            nc.styleCell()

            cell = nc
            
        default:
            return cell
        }
        
        return cell
    }
    
}
