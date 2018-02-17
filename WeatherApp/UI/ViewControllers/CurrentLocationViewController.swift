//
//  CurrentLocationViewController.swift
//  WeatherApp
//
//  Created by maksim_p on 16.02.2018.
//  Copyright © 2018 maksim_p. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps


class CurrentLocationViewController: UIViewController {
    
    @IBOutlet weak var tempImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var currentCityLabel: UILabel!
    @IBOutlet fileprivate weak var mapView: GMSMapView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    let locationManager = CLLocationManager()
    var timer: Timer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocationManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if timer == nil {
            startTimer()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        stopTimer()
    }
    
    func startTimer () {
        if firstView.isHidden {
            if timer == nil {
                timer =  Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
            }
        }
    }
    
    func stopTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func setMap(city: PlacemarkCity) {
        let camera = GMSCameraPosition.camera(withLatitude: city.lat, longitude: city.lon, zoom: 6.0)
        mapView.camera = camera
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        showMarker(position: camera.target, city: city)
    }
    
    func showMarker(position: CLLocationCoordinate2D, city: PlacemarkCity){
        let marker = GMSMarker()
        marker.position = position
        marker.title = city.city
        marker.snippet = city.country
        marker.map = mapView
    }
    
    @IBAction func showDetailInfoButtonPressed(_ sender: Any) {
        
        if InternetCheck.isConnectedToNetwork() {
            let selectedItem = self.currentCityLabel.text
            let viewController = DetailsWeatherTableViewController()
            viewController.nameCity = selectedItem!
            navigationController?.pushViewController(viewController, animated: true)
        }else {
            stopTimer()
            showMessage("No Internet")
        }
    }
    
    @objc func update() {
        
        if InternetCheck.isConnectedToNetwork() {
            
            APIProvider().getCityInfo(city: self.currentCityLabel.text!) { (city) in
                if self.tempLabel.text != "\(String(format:"%.0f", city.temp!)) º" {
                    self.tempLabel.text = "\(String(format:"%.0f", city.temp!)) º"
                }
                if self.tempImageView.restorationIdentifier != city.icon {
                    self.tempImageView.image = UIImage(named: city.icon!)
                }
            }
        }else {
            stopTimer()
            showMessage("No Internet")
        }
    }
}
