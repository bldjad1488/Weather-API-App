//
//  ViewController.swift
//  Weather API App
//
//  Created by Polina Prokopenko on 08.08.2021.
//

import UIKit
import CoreLocation


class WeatherViewController: UIViewController {
    
    @IBOutlet var weatherTable: UITableView!
    
    let manager = CLLocationManager()
    var currentLocation: CLLocation?
    var cityName = ""
    
    var dailyWeather = [DailyWeather]()
    var currentWeather: CurrentWeather?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        setupLocation()
    }

}


