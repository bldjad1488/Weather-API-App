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
    
    var dailyWeather = [DailyWeather]()
    
    let apiKey = "bbbf6104b2f68bb1d55d2597ee18ba3a"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTable()
        requestWeather()
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
        
        print("\(latitude) \(longitude)")
        
        let apiURL = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=alerts,minutely&units=metric&appid=\(apiKey)"
        
        URLSession.shared.dataTask(with: URL(string: apiURL)!, completionHandler: { data, response, error in
            guard let data = data else {
                print("Can't get JSON. Error: \(error)")
                return
            }
            
            let json: WeatherResponse
            
            do {
                json = try JSONDecoder().decode(WeatherResponse.self, from: data)
                
                self.dailyWeather = json.daily
                print(self.dailyWeather)
            } catch {
                print(error)
            }
            
            DispatchQueue.main.async {
                self.weatherTable.reloadData()
            }
            
        }).resume()
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyWeather.count // заглушка
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.identifier, for: indexPath) as! DailyTableViewCell
        
        cell.configure(with: self.dailyWeather[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
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
