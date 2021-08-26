//
//  Network.swift
//  Network
//
//  Created by Polina Prokopenko on 26.08.2021.
//

import Foundation


extension WeatherViewController {
    
    func requestWeather() {
        guard let currentLocation = currentLocation else { return }

        let latitude = currentLocation.coordinate.latitude
        let longitude = currentLocation.coordinate.longitude
        let apiKey = "bbbf6104b2f68bb1d55d2597ee18ba3a"
        
        let apiURL = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=alerts,minutely&units=metric&appid=\(apiKey)"
        
        URLSession.shared.dataTask(with: URL(string: apiURL)!, completionHandler: { data, response, error in
            guard let data = data else {
                print(error!)
                return
            }
            
            let json: WeatherResponse
            
            do {
                json = try JSONDecoder().decode(WeatherResponse.self, from: data)
                
                self.dailyWeather = json.daily
                self.dailyWeather.remove(at: 0)
                self.currentWeather = json.current
            } catch {
                print(error)
            }
            
            DispatchQueue.main.async {
                self.weatherTable.reloadData()
                self.weatherTable.tableHeaderView = self.createHeader()
            }
            
        }).resume()
    }
    
}
