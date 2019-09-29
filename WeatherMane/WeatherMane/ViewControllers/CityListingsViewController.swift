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
 
 */

import UIKit


class CityListingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var laData: Forecast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //disable scrolling since we are using a TableView but only loading 1 item
        tableView.isScrollEnabled = false
        
        self.navigationController?.isNavigationBarHidden = true

        // set alpha to 0 until data loads in order to prevent flashing
        tableView.alpha = 0.0
        
        // pulls forecast of Los Angeles using DarkSky API
        WMAPI.fetchGenericForecasts(urlString: "https://api.darksky.net/forecast/427c1a7660ed6eed6afec22ef35ae055/37.8267,-122.4233?&exclude=minutely,flags,daily,alert") { (fc: Forecast) in
            self.laData = fc
            DispatchQueue.main.async {
                self.tableView.alpha = 1.0

            }
        }
        
    }
            
}

extension CityListingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //static height for now
        //maybe use UIAutomaticTableDimension
        return 250
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ForecastDetailsViewController") as! ForecastDetailsViewController
        
        guard let d = laData?.hourlyWeather.data,
                let cw = laData?.currentWeather,
                    let gd = laData else {
                            return
        }
        
        vc.hourlyData = d
        vc.currentData = cw
        vc.generalData = gd
    
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension CityListingsViewController: UITableViewDataSource {

    func tableView(_ tableView : UITableView, numberOfRowsInSection section: Int) -> Int {
        //since we are only fetching 1 item from the API, return 1
        //if we add more forecasts, refactor tableData -> [tableData] and return tableData.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityDetailsTableViewCell", for: indexPath) as! CityDetailsTableViewCell
        
        // pass the data to the cell
        cell.forecast = laData
        cell.currentWeather = laData?.currentWeather
        cell.hourlyData = laData?.hourlyWeather.data[indexPath.row]
        
        // set the data
        cell.setData(hourlyData: laData?.hourlyWeather.data[indexPath.row], currentWeather: laData?.currentWeather)
        
        // style the cell accordingly
        cell.styleCell()


        return cell
    }
    
}
