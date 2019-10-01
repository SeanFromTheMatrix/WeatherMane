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
 
 On master branch, I have loaded Hourly weather forcasts into the initial tableViewController. The application displays some high level data abour the forcast for each hour at a different indexPath. When user selectedItemAtIndexPath, the navigation controller pushes to a detailVC that shows more information about the hourly forecast, the current weather, and some general location data.
 
    * I think the implementation that is on the master branch is better suited for the API that I chose. It allows for a better understanding of what the weather is like in Los Angeles
 
 
 On the branch named 'working build', I have displayed 1 tableViewCell that shows some high levels details about Los Angeles' forecast. The cell contains all of the data that was fetched from the API. When a user taps on the cell, it will show detailed information about the LA weather forecast.
 
    * I would prefer the implementation on the 'working build' branch if the API returned a list of locations (ex. LA, NY, HI, AZ) so that I could pump all of those locations into tableViewCells on the homescreen to allow for a more comprehensive weather report
 
 ~~~~~~~~~~~~
 I've noticed that the URL is not returning accurate data. I entered the URL into a web browser and it appears that the API is returning incorrect temperature values. It is currently 64 degrees F, but the app is showing that it is 59 degrees F.
 ~~~~~~~~~~~~
 */

import UIKit


class CityListingsViewController: UIViewController {

    // Create an outlet for the tableView
    @IBOutlet weak var tableView: UITableView!
    
    // Create dataSource for the cell
    var tableData: Forecast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set delegate and dataSource of the tableView to the viewController
        tableView.delegate = self
        tableView.dataSource = self
        
        // Hide nav bar
        self.navigationController?.isNavigationBarHidden = true

        // Set alpha to 0 until data loads in order to prevent flashing
        tableView.alpha = 0.0
        
        // Pulls forecast of Los Angeles using DarkSky API
        fetchHourlyForecasts()
        
    }
    
    func fetchHourlyForecasts() {
    
        // WMAPI contains the method to retreive data
        WMAPI.fetchGenericForecasts(urlString: "https://api.darksky.net/forecast/427c1a7660ed6eed6afec22ef35ae055/37.8267,-122.4233?&exclude=minutely,flags,daily,alerts") { (fc: Forecast) in
            
            // Set the tableView dataSource
            self.tableData = fc
            
            // Reload the tableView to show data
            DispatchQueue.main.async {
                
                // Reload the data
                self.tableView.reloadData()

                // Animated with a duration
                UIView.animate(withDuration: 0.6) {
                    
                    // Fade in the tableView
                    self.tableView.alpha = 1.0
                    
                }
            }
        }
    }
    
}

extension CityListingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // Check for data, if there is no data return 0 for height
        guard let _  = tableData else {
            return 0.0
        }
        
        // Static height for now
        // Maybe use UIAutomaticTableDimension
        return 200
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Need to access values from ForeCastDetailsViewController, to pass data on didSelectRow
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ForecastDetailsViewController") as! ForecastDetailsViewController
        
        // Check for data
        guard let gd = tableData else {
            return
        }
        
        // Pass the necessary data to VC
        vc.generalData = gd
        vc.currentData = gd.currentWeather
        vc.hourlyData = gd.hourlyWeather.data[indexPath.row]
    
        // Navigate to viewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension CityListingsViewController: UITableViewDataSource {

    // Determind number of rows in each section
    func tableView(_ tableView : UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Check for data, if no data return 0 sections
        guard let td = tableData else {
            return 0
        }
       
        // Return the number of items in the [data]
        return td.hourlyWeather.data.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create cell to use of there is no data
        let c = UITableViewCell()
        let noData: String = "Error getting forecasts"
        
        c.textLabel?.text = noData
        c.textLabel?.textColor = UIColor.black
        c.textLabel?.textAlignment = .center
        c.textLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        // Check for data, if no data return empty cell
        guard let td = tableData else {
            return c
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityDetailsTableViewCell", for: indexPath) as! CityDetailsTableViewCell

        // Pass the [data]
        cell.hourlyData = td.hourlyWeather.data[indexPath.row]
        
        // Style the cell accordingly
        cell.styleCell()

        // Return the cell to the tableView
        return cell
    }
    
}
