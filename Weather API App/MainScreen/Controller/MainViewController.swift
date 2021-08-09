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
    
    var data: WeatherResponse?
    let apiKey = "bbbf6104b2f68bb1d55d2597ee18ba3a"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
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
        guard let currentLocation = currentLocation else { return }

        let latitude = currentLocation.coordinate.latitude
        let longitude = currentLocation.coordinate.longitude
        
        let apiURL = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=alerts,minutely&units=metric&appid=\(apiKey)"
        
        URLSession.shared.dataTask(with: URL(string: apiURL)!, completionHandler: { data, response, error in
            guard let data = data else {
                print("Can't get JSON")
                return
            }
            
            let json: WeatherResponse?
            do {
                json = try JSONDecoder().decode(WeatherResponse.self, from: data)
                self.data = json
            } catch {
                print(error)
            }
            
        }).resume()
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15 // заглушка
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
