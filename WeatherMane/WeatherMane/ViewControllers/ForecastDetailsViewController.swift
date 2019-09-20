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
    
    var generalData: Forecast?
    var currentData: CurrentWeather?
    var hourlyData: HourlyData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
    }
    

}

extension ForecastDetailsViewController: UITableViewDelegate {
    
}

extension ForecastDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ForeCastSections.allCases.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case ForeCastSections.general.rawValue:
            return 1
        case ForeCastSections.current.rawValue:
            return 3
        case ForeCastSections.hourly.rawValue:
            return 3
        default:
            return 0
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = Bundle.main.loadNibNamed("ForecastDetailHeaderView", owner: self, options: nil)?.first as? UIView
        self.tableView.tableHeaderView = view

        switch section {
        case ForeCastSections.general.rawValue:
            
            return view
        case ForeCastSections.current.rawValue:
            return view
        case ForeCastSections.hourly.rawValue:
            return view
        default:
            return view
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
