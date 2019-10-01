//
//  ForecastDetailsViewController.swift
//  WeatherMane
//
//  Created by Sean Bukich on 9/19/19.
//  Copyright © 2019 Sean Bukich. All rights reserved.
//

import UIKit

// Create an enumeration for the different sections of this viewController
enum ForeCastSections: Int, CaseIterable {
    case general = 0
    case current = 1
    case hourly = 2
}

class ForecastDetailsViewController: UIViewController {

    // Attach tableView to the viewController
    @IBOutlet weak var tableView: UITableView!
    
    // Create an outlet for the view that will receive TapGesture and popVc method
    @IBOutlet weak var goBackTapArea: UIView!
    
    // Create a dataSource
    var generalData: Forecast?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the tableView delegate and dataSource
        tableView.delegate = self
        tableView.dataSource = self
        
        // Initialize tap gestures
        setUpGestures()
        
    }
    
    // Create function to handle all tap gestures
    func setUpGestures() {
        
        // Set up tap to go back tap gesture recognizer
        let goBackTap = UITapGestureRecognizer(target: self, action: #selector(backTapAction(_:)))
        goBackTapArea.addGestureRecognizer(goBackTap)
    }
    
    // Method to add to selector on UITapGestureRecognizer
    @objc func backTapAction(_ t: UITapGestureRecognizer) {
        
        // Tell navigationController to pop back to previous vc
        self.navigationController?.popViewController(animated: true)
    }

}

extension ForecastDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // Make sure we have data
        guard let _ = generalData else {
            return 0
        }
        
        // Set heights for each cell
        switch indexPath.section {
            
        case ForeCastSections.general.rawValue:
            return 100
            
        case ForeCastSections.current.rawValue:
            return 150
            
        case ForeCastSections.hourly.rawValue:
            return 150
            
        default:
            return 0
            
        }
    }
    
}

extension ForecastDetailsViewController: UITableViewDataSource {
    
    // Tell UITableViewDataSource how many sections there will be
    func numberOfSections(in tableView: UITableView) -> Int {
        
        // Since the ForeCastSections subclasses caseIterable and Int, we can returnt the number of cases by using .count
        return ForeCastSections.allCases.count
    }
    
    // Return the number of rows in each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Make sure we have data
        guard let gd = generalData else {
            return 0
        }
        
        switch section {
        case ForeCastSections.general.rawValue:
            return 1
            
        case ForeCastSections.current.rawValue:
            return 1
            
        case ForeCastSections.hourly.rawValue:
            return gd.hourlyWeather.data.count
            
        default:
            return 1

        }
    }
    
    // Set up the headers for each section in the viewController
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        // Load the nib for the headers
        let view = Bundle.main.loadNibNamed("ForecastDetailHeaderView", owner: self, options: nil)![0] as? ForecastDetailHeaderView
        
        switch section {
            
        case ForeCastSections.general.rawValue:
            // Set the header title
            view?.forecastTypeLabel.text = "Location"
            return view
            
        case ForeCastSections.current.rawValue:
            // Set the header title
            view?.forecastTypeLabel.text = "Current Forecast"
            return view
            
        case ForeCastSections.hourly.rawValue:
            // Set the header title
            view?.forecastTypeLabel.text = "Previous Forecasts by the Hour"
            return view
            
        default:
            return view
        }
    }
    
    // Pass data to the individual cells appearing on the viewControllerww
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        // Make sure we have data
        guard let gd = generalData else {
            return cell
        }
        
        switch indexPath.section {
            
        // Show general information for the selected location
        case ForeCastSections.general.rawValue:
            let nc = tableView.dequeueReusableCell(withIdentifier: "GeneralDetailsTableViewCell", for: indexPath) as! GeneralDetailsTableViewCell
            
            nc.dataSource = gd
            nc.styleCell()
            cell = nc
            
        // Show current weather conditions for the selected location
        case ForeCastSections.current.rawValue:
            let nc = tableView.dequeueReusableCell(withIdentifier: "CurrentDetailsTableViewCell", for: indexPath) as! CurrentDetailsTableViewCell
            
            nc.currentWeather = gd.currentWeather
            nc.styleCell()

            cell = nc
            
        // Show hourly forecasts for the selected location
        case ForeCastSections.hourly.rawValue:
            let nc = tableView.dequeueReusableCell(withIdentifier: "HourlyDetailsTableViewCell", for: indexPath) as! HourlyDetailsTableViewCell
            
            nc.hourlyData = gd.hourlyWeather.data[indexPath.row]
            nc.styleCell()

            cell = nc
            
        default:
            return cell
        }
        
        return cell
    }
    
    // Set heights for the header in each section
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
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
}

