//
//  CoreLocation.swift
//  WeatherApp
//
//  Created by maksim_p on 16.02.2018.
//  Copyright © 2018 maksim_p. All rights reserved.
//

import Foundation
import CoreLocation
import PKHUD

extension CurrentLocationViewController : CLLocationManagerDelegate {
    
    // MARK: location manager
    func setupLocationManager(){
        self.showLoader()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let currentLocation = locations.last else { return }
        locationManager.stopUpdatingLocation()
        
        getCityStringFromLocation(location: currentLocation) { currentCity in
            self.setMap(city: currentCity)
            APIProvider().getCityInfo(city: currentCity.city, completion: { (cityInfo) in
                
                self.tempImageView.image = UIImage(named: cityInfo.icon!)
                self.currentCityLabel.text = cityInfo.name!
                self.tempLabel.text = "\(String(format:"%.0f", cityInfo.temp!)) º"
                self.hideLoader()
            })
        }
    }
    
    func getCityStringFromLocation(location: CLLocation ,completionHandler: @escaping (PlacemarkCity) -> ()) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) {
            (placemarks, error) -> Void in
            let placeArray = placemarks as [CLPlacemark]!
            var placeMark: CLPlacemark!
            placeMark = placeArray?[0]
            if let placeMark = placeMark,
                let dict = placeMark.locality,
                let country = placeMark.country,
                let lon = placeMark.location?.coordinate.longitude,
                let lat = placeMark.location?.coordinate.latitude
            {
                let cityPlaceMark = PlacemarkCity(city: dict, country: country, lat: lat, lon: lon)
                completionHandler(cityPlaceMark)
            }else{
                print("Error from location")
            }
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("error:: \(error)")
        //        showAlertMessage(title: "ERROR", message: "Нou have some problems with location ")
        locationManager.stopUpdatingLocation()
    }
}
