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
 
Tapping on a cell will display more detailed forecast information about the different cities at each indexPath
 
*/

import UIKit

enum ListingCity {
    case LA, NY
}


class CityListingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var laData: Forecast?
    var nyData: Forecast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //disable scrolling since we are using a TableView but only loading 1 item
        tableView.isScrollEnabled = false
        
        self.navigationController?.isNavigationBarHidden = true

        // set alpha to 0 until data loads in order to prevent flashing
        tableView.alpha = 0.0
        
        apiCallBlock()
    
        
    }
    
    func apiCallBlock(){
        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        
        WMAPI.fetchGenericForecasts(urlString: "https://api.darksky.net/forecast/427c1a7660ed6eed6afec22ef35ae055/37.8267,-122.4233?&exclude=minutely,flags,daily,alert") { (fc: Forecast) in
            self.laData = fc
            
            DispatchQueue.main.async {
                dispatchGroup.leave()
            }

        }
        
        dispatchGroup.enter()
        WMAPI.fetchGenericForecasts(urlString: "https://api.darksky.net/forecast/427c1a7660ed6eed6afec22ef35ae055/42.3601,-71.0589?&exclude=minutely,flags,daily,alert") { (fc: Forecast) in
            self.nyData = fc
            
            DispatchQueue.main.async {
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            
            // tasks have been completed, do what you will
            
            self.tableView.reloadData()
            
            UIView.animate(withDuration: 0.7) {
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
        
        if indexPath.row == 0 {
            
            guard let d = laData else {
                return
            }
            
            vc.generalData = d
            vc.currentData = d.currentWeather
            vc.hourlyData = d.hourlyWeather.data
            
        } else {
            
            guard let d = nyData else {
                return
            }
            
            vc.generalData = d
            vc.currentData = d.currentWeather
            vc.hourlyData = d.hourlyWeather.data
            
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension CityListingsViewController: UITableViewDataSource {

    func tableView(_ tableView : UITableView, numberOfRowsInSection section: Int) -> Int {
        //since we are only fetching 1 item from the API, return 1
        //if we add more forecasts, refactor tableData -> [tableData] and return tableData.count
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityDetailsTableViewCell", for: indexPath) as! CityDetailsTableViewCell
        
        if indexPath.row == 0 {
            // pass the data to the cell
            cell.forecast = laData
            cell.currentWeather = laData?.currentWeather
            cell.hourlyData = laData?.hourlyWeather.data[indexPath.row]
            cell.cellLocation = .LA
            
            // set the data
            cell.setData(hourlyData: laData?.hourlyWeather.data[indexPath.row], currentWeather: laData?.currentWeather)
        } else {
            // pass the data to the cell
            cell.forecast = nyData
            cell.currentWeather = nyData?.currentWeather
            cell.hourlyData = nyData?.hourlyWeather.data[indexPath.row]
            cell.cellLocation = .NY

            // set the data
            cell.setData(hourlyData: nyData?.hourlyWeather.data[indexPath.row], currentWeather: nyData?.currentWeather)
        }
        
        
        // style the cell accordingly
        cell.styleCell()


        return cell
    }
    
}
