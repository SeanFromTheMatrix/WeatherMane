//
//  CityListingsViewController.swift
//  WeatherMane
//
//  Created by Sean Bukich on 9/18/19.
//  Copyright © 2019 Sean Bukich. All rights reserved.
//

import UIKit

class CityListingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var tableData: [Forecast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Refactor and figure out how to get multiple locations with 1 URLSession
        fetchLAForecasts()
        fetchNYForecasts()
        fetchHIForecasts()
    }
    
    func fetchLAForecasts() {

        // Using Los Angeles' cordinates
        let urlString = "https://api.darksky.net/forecast/427c1a7660ed6eed6afec22ef35ae055/37.8267,-122.4233?&exclude=minutely,flags,daily,alerts"

        guard let url = URL(string: urlString) else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let d = data else {
                return
            }

            do {
                
                let forecasts = try JSONDecoder().decode(Forecast.self, from: d)
                self.tableData.append(forecasts)
                
            } catch {
                print("error", error)
            }

        }.resume()

    }
    
    func fetchNYForecasts() {
        
        // Using NYs' cordinates
        let urlString = "https://api.darksky.net/forecast/427c1a7660ed6eed6afec22ef35ae055/42.3601,-71.0589?&exclude=minutely,flags,daily,alerts"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let d = data else {
                return
            }
            
            do {
                
                let forecasts = try JSONDecoder().decode(Forecast.self, from: d)
                self.tableData.append(forecasts)
                
            } catch {
                print("error", error)
            }
            
        }.resume()
        
    }
    
    func fetchHIForecasts() {
        
        // Using HIs' cordinates
        let urlString = "https://api.darksky.net/forecast/427c1a7660ed6eed6afec22ef35ae055/20.7161,-158.214676?&exclude=minutely,flags,daily,alerts"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let d = data else {
                return
            }
            
            do {
                
                let forecasts = try JSONDecoder().decode(Forecast.self, from: d)
                self.tableData.append(forecasts)
                
            } catch {
                print("error", error)
            }
            
        }.resume()

    }
    
    
}

extension CityListingsViewController: UITableViewDelegate {
    
}

extension CityListingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityDetailsTableViewCell", for: indexPath) as! CityDetailsTableViewCell
        
        return cell
    }
    
    
}
