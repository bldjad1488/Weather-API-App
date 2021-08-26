//
//  WeatherModel.swift
//  WeatherModel
//
//  Created by Polina Prokopenko on 09.08.2021.
//

import Foundation

// For checking API
// https://api.openweathermap.org/data/2.5/onecall?lat=55.63896621060778&lon=37.32636603970181&exclude=alerts,minutely&units=metric&appid=bbbf6104b2f68bb1d55d2597ee18ba3a

struct WeatherResponse: Codable {
    
    let lat: Float
    let lon: Float
    let timezone: String
    let timezone_offset: Int

    let current: CurrentWeather
    let hourly: [HourlyWeather]
    let daily: [DailyWeather]
}

struct WeatherDescription: Codable {
    
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct CurrentWeather: Codable {
    
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Float
    let weather: [WeatherDescription]
}

struct HourlyWeather: Codable {
    
    let dt: Int
    let temp: Float
    let weather: [WeatherDescription]
}

struct DailyWeather: Codable {
    
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Temperature
    let weather: [WeatherDescription]
    
    struct Temperature: Codable {
        let day: Float
        let min: Float
        let max: Float
        let night: Float
        let eve: Float
        let morn: Float
    }
}

