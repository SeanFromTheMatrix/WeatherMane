//
//  CityListingsViewController.swift
//  WeatherMane
//
//  Created by Sean Bukich on 9/18/19.
//  Copyright © 2019 Sean Bukich. All rights reserved.
//

/*
 ~~~ DEV NOTES ~~~
 
The API I chose to use (DARK SKY) only loaded 1 super object with nested objects inside of it.
 
This branch 'networkLayerRefactor' is set up to load forecasts from different locations.
 
I have implemented a dispatch group to handle two concurrent API calls.
 
Tapping on a cell will display more detailed information about the different cities at each indexPath
 
 
 ~~~~~~
 I've noticed that DarkSky API is not returning precise data. The temperatures are off in both Los Angeles and New York.
 Tested to make sure this is not an error on my end by entering the URL into a web browser. Response shows 60 degrees F, while it is really 69 degrees F.
 ~~~~~~
 
 If error persists, switch API services.
 
 Consider making an array [ForeCast] to use for the datasource, instead of separate sources for LA and NY.
 
*/

import UIKit

// Create context to determine cell types for different UI's
enum ListingCity {
    case LA, NY
}

class CityListingsViewController: UIViewController {

    // Attach tabelView to the viewController
    @IBOutlet weak var tableView: UITableView!
    
    // Create Datasources
    var laData: Forecast?
    var nyData: Forecast?
    
    // NOTE: Will need this variable if I decide to append API results to a single dataSource
//    var dataSource: [Forecast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the tableView delegate and dataSource
        tableView.delegate = self
        tableView.dataSource = self
        
        // Disable scrolling because only loading two items for now
        tableView.isScrollEnabled = false
        
        // Hide the navigation bar for my preferred UI
        self.navigationController?.isNavigationBarHidden = true

        // Set alpha to 0 until data loads in order to prevent flashing
        tableView.alpha = 0.0
        
        // Start api calls
        apiCallBlock()
    
        
    }
    
    // Create function to handle Network Requests
    func apiCallBlock(){
        
        // Create a dispatchGroup to manage the simultaneous api calls
        let dispatchGroup = DispatchGroup()

        // Enter the group start the api calls
        dispatchGroup.enter()
        
        // Fetch forecast for los angeles
        WMAPI.fetchGenericForecasts(urlString: "https://api.darksky.net/forecast/427c1a7660ed6eed6afec22ef35ae055/37.8267,-122.4233?&exclude=minutely,flags,daily,alert") { (fc: Forecast) in
            
            // Set the data to the LA variable
            self.laData = fc
            
            // Leave the dispatch group
            DispatchQueue.main.async {
                dispatchGroup.leave()
            }

        }
        
        // Enter the group for the second API call
        dispatchGroup.enter()
        WMAPI.fetchGenericForecasts(urlString: "https://api.darksky.net/forecast/427c1a7660ed6eed6afec22ef35ae055/42.3601,-71.0589?&exclude=minutely,flags,daily,alert") { (fc: Forecast) in
            
            // Set the data to the NY variable
            self.nyData = fc
            
            // Leaver the dispatch group
            DispatchQueue.main.async {
                dispatchGroup.leave()
            }
        }

        // All calls have finished, handle tableView updates
        dispatchGroup.notify(queue: .main) {
            
            // Reload the tableView to show data
            self.tableView.reloadData()
            
            // Fade in the tableView
            UIView.animate(withDuration: 0.6) {
                self.tableView.alpha = 1.0
            }
        }
    }

    
}

extension CityListingsViewController: UITableViewDelegate {
    
    // Set cell heights
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // Static height for now
        return 250
        
    }
    
    // Handle cell selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Let tableView delegate know which view controller we want to access on didSelect
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ForecastDetailsViewController") as! ForecastDetailsViewController
        
        // Check on the indexPath
        if indexPath.row == 0 {
            
            // Check to see if there are values in laData
            guard let d = laData else {
                return
            }
            
            // Pass the data to the desired viewController
            vc.generalData = d
            
        } else {
            
            // Check to see if there are values in nyData
            guard let d = nyData else {
                return
            }
            
            // Pass the data to the desired viewController
            vc.generalData = d
            
        }
        
        // Navigate to the desired viewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension CityListingsViewController: UITableViewDataSource {

    // Return the number of rows in each section
    func tableView(_ tableView : UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return 2 because we only have LA and NY as potential datasources
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create an instance of the cell we want to access
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityDetailsTableViewCell", for: indexPath) as! CityDetailsTableViewCell
        
        // Check to see which index patgh is being accessed
        if indexPath.row == 0 {
            // Pass the data to the cell
            cell.forecast = laData
            
            // Set the context for the cell
            cell.cellLocation = .LA
            
        } else {
            // Pass the data to the cell
            cell.forecast = nyData
            
            // Set the context for the cell
            cell.cellLocation = .NY
            
        }
        
        
        // Style the cell accordingly
        cell.styleCell()

        // Return the cell
        return cell
    }
    
}
