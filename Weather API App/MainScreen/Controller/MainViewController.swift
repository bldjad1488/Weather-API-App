//
//  ViewController.swift
//  Weather API App
//
//  Created by Polina Prokopenko on 08.08.2021.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    
    @IBOutlet var weatherTable: UITableView!
    
    let manager = CLLocationManager()
    var currentLocation: CLLocation?
    
    var data = [Weather]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTable()
        setupLocation()
    }
    
    func setupTable() {
        weatherTable.delegate = self
        weatherTable.dataSource = self
        
        weatherTable.register(DailyTableViewCell.nib(), forCellReuseIdentifier: DailyTableViewCell.identifier)
        weatherTable.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
    }
    
    func setupLocation() {
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func requestWeather() {
        guard let currentLocation = currentLocation else {
            return
        }

        let longitude = currentLocation.coordinate.longitude
        let latitude = currentLocation.coordinate.latitude
        
        print("\(longitude) | \(latitude)")
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

extension MainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            manager.stopUpdatingLocation()
            requestWeather()
        }
        
    }

}
