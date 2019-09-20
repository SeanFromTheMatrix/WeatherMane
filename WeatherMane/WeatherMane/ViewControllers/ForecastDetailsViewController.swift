//
//  ForecastDetailsViewController.swift
//  WeatherMane
//
//  Created by Sean Bukich on 9/19/19.
//  Copyright © 2019 Sean Bukich. All rights reserved.
//

import UIKit

enum ForeCastSections: Int, CaseIterable {
    case general = 0
    case current = 1
    case hourly = 2
}

class ForecastDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var goBackTapArea: UIView!
    
    var generalData: Forecast?
    var currentData: CurrentWeather?
    var hourlyData: [HourlyData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        setUpGestures()
        
    }
    
    func setUpGestures() {
        let goBackTap = UITapGestureRecognizer(target: self, action: #selector(backTapAction(_:)))
        goBackTapArea.addGestureRecognizer(goBackTap)
    }
    
    @objc func backTapAction(_ t: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension ForecastDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ForeCastSections.allCases.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case ForeCastSections.general.rawValue:
            if generalData == nil {
                return 0
            }
            
            return 1
        case ForeCastSections.current.rawValue:
            return 1
        case ForeCastSections.hourly.rawValue:
            return hourlyData.count
        default:
            return 1

        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let view = Bundle.main.loadNibNamed("ForecastDetailHeaderView", owner: self, options: nil)![0] as? ForecastDetailHeaderView
        
        switch section {
        case ForeCastSections.general.rawValue:
            view?.forecastTypeLabel.text = "Location"
            return view
        case ForeCastSections.current.rawValue:
            view?.forecastTypeLabel.text = "Current Forecast"
            return view
        case ForeCastSections.hourly.rawValue:
            view?.forecastTypeLabel.text = "Previous Forecasts by the Hour"
            return view
        default:
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        switch indexPath.section {
        case ForeCastSections.general.rawValue:
            let nc = tableView.dequeueReusableCell(withIdentifier: "GeneralDetailsTableViewCell", for: indexPath) as! GeneralDetailsTableViewCell
            
            nc.dataSource = generalData
            nc.styleCell()
            cell = nc
        case ForeCastSections.current.rawValue:
            let nc = tableView.dequeueReusableCell(withIdentifier: "CurrentDetailsTableViewCell", for: indexPath) as! CurrentDetailsTableViewCell
            
            nc.currentWeather = currentData
            nc.styleCell()

            cell = nc
        case ForeCastSections.hourly.rawValue:
            let nc = tableView.dequeueReusableCell(withIdentifier: "HourlyDetailsTableViewCell", for: indexPath) as! HourlyDetailsTableViewCell
            
            nc.hourlyData = hourlyData[indexPath.row]
            nc.styleCell()

            cell = nc
        default:
            return cell
        }
        
        return cell
    }
    
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
