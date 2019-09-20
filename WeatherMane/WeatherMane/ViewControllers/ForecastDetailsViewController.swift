//
//  ForecastDetailsViewController.swift
//  WeatherMane
//
//  Created by Sean Bukich on 9/19/19.
//  Copyright © 2019 Sean Bukich. All rights reserved.
//

import UIKit

class ForecastDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}

extension ForecastDetailsViewController: UITableViewDelegate {
    
}

extension ForecastDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
