//
//  TableSettings.swift
//  TableSettings
//
//  Created by Polina Prokopenko on 26.08.2021.
//

import Foundation
import UIKit


extension WeatherViewController {
    
    func setupTable() {
        weatherTable.delegate = self
        weatherTable.dataSource = self
        
        weatherTable.register(DailyTableViewCell.nib(), forCellReuseIdentifier: DailyTableViewCell.identifier)
    }
    
    func createHeader() -> UIView {
        guard let currentWeather = currentWeather else {
            return UIView()
        }
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width - 95))
        
        let currentLocationLabel = UILabel(frame: CGRect(x: 10, y: 10, width: view.frame.size.width - 20, height: view.frame.size.width / 5))
        currentLocationLabel.text = cityName
        currentLocationLabel.textAlignment = .center
        currentLocationLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 20)
        
        let weatherConditionImageView = UIImageView(frame: CGRect(x: header.center.x - 40, y: currentLocationLabel.frame.size.height, width: 80, height: 80))
        weatherConditionImageView.contentMode = .scaleAspectFit
        weatherConditionImageView.image = UIImage(named: "rain")
        
        let condition = currentWeather.weather[0].description
        
        if condition.contains("rain") {
            weatherConditionImageView.image = UIImage(named: "rain")
        } else if condition.contains("clear") {
            weatherConditionImageView.image = UIImage(named: "clear")
        } else if condition.contains("clouds") {
            weatherConditionImageView.image = UIImage(named: "clouds")
        } else if condition.contains("drizzle") {
            weatherConditionImageView.image = UIImage(named: "rain")
        } else if condition.contains("thunderstorm") {
            weatherConditionImageView.image = UIImage(named: "thunderstorm")
        } else if condition.contains("snow") {
            weatherConditionImageView.image = UIImage(named: "snow")
        } else {
            weatherConditionImageView.image = UIImage(named: "rain")
        }
        
        let temperatureLabel = UILabel(frame: CGRect(x: header.center.x - 40, y: weatherConditionImageView.frame.size.height + 70, width: 80, height: 80))
        temperatureLabel.text = "\(Int(currentWeather.temp))°"
        temperatureLabel.textAlignment = .center
        temperatureLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 50)
        
        let descriptionLabel = UILabel(frame: CGRect(x: header.center.x - header.frame.size.width / 2, y: temperatureLabel.frame.size.height + 120, width: header.frame.size.width, height: 80))
        descriptionLabel.text = "\(currentWeather.weather[0].description)"
        descriptionLabel.textAlignment = .center
        
        header.addSubview(currentLocationLabel)
        header.addSubview(weatherConditionImageView)
        header.addSubview(temperatureLabel)
        header.addSubview(descriptionLabel)
        
        return header
    }
    
}


extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyWeather.count
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
