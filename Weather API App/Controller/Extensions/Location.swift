//
//  Location.swift
//  Location
//
//  Created by Polina Prokopenko on 26.08.2021.
//

import Foundation
import CoreLocation


extension WeatherViewController {
    
    func setupLocation() {
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func getPlaceFromCoordinates(_ coordinates: CLLocationCoordinate2D) {
        let geocoder = CLGeocoder()
        
        let latitude = coordinates.latitude
        let longitude = coordinates.longitude
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            self.cityName = self.processResponse(withPlacemarks: placemarks, error: error)
        }
    }
    
    func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) -> String {
        if let error = error {
            print(error)
            return "Unable to find adress"
        } else {
            if let placemarks = placemarks, let placemark = placemarks.first {
                return placemark.compactAddress!
            } else {
                return "No matching adress found"
            }
        }
    }
    
}


extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            manager.stopUpdatingLocation()
            getPlaceFromCoordinates(locations.first!.coordinate)
            requestWeather()
        }
        
    }

}


extension CLPlacemark {

    var compactAddress: String? {
        if let name = name {
            var result = name

            if let city = locality {
                result = "\(city)"
            }
            return result
        }
        return nil
    }

}
