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
    
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Curent city"
        setupLocationManager()
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
        
        let selectedItem = self.currentCityLabel.text
        let viewController = DetailsWeatherTableViewController()
        viewController.nameCity = selectedItem!
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension CurrentLocationViewController: GMSMapViewDelegate{
    /* handles Info Window tap */
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("didTapInfoWindowOf")
    }
    
    /* handles Info Window long press */
    func mapView(_ mapView: GMSMapView, didLongPressInfoWindowOf marker: GMSMarker) {
        print("didLongPressInfoWindowOf")
    }
    
    /* set a custom Info Window */
   
}
