//
//  ViewController.swift
//  WeatherApp
//
//  Created by maksim_p on 10.12.2017.
//  Copyright © 2017 maksim_p. All rights reserved.
//

import UIKit
import MapKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let request = MKLocalSearchRequest()
    var matchingItems:[PlacemarkCity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Search city"
        self.tableView.register(UINib(nibName: String(describing: CityTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CityTableViewCell.self))
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 80
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CityTableViewCell.self), for: indexPath) as! CityTableViewCell
        cell.configure(city: matchingItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[indexPath.row].city
        let viewController = DetailsWeatherTableViewController()
        viewController.nameCity = selectedItem
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}

extension SearchViewController : UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let search = MKLocalSearch(request: request)
        self.request.naturalLanguageQuery = searchText
        if searchText.isEmpty || searchBar.text == "" {
            search.cancel()
            tableView.reloadData()
        }
        
        search.start { response, _ in
            if let responseMapIndex = response?.mapItems {
                let filteredMapItems = responseMapIndex.filter({ mapItem -> Bool in
                    return mapItem.placemark.locality != nil && mapItem.placemark.country != nil
                })
                let placemarks = filteredMapItems.map({ mapItem -> PlacemarkCity in
                    let placemarkInfo = PlacemarkCity(city: mapItem.placemark.locality!, country: mapItem.placemark.country!, lat: mapItem.placemark.coordinate.latitude, lon: mapItem.placemark.coordinate.longitude)
                    return placemarkInfo
                })
                var matchingItems = [PlacemarkCity]()
                for placemark in placemarks {
                    if !matchingItems.contains(where: { matchingItem -> Bool in
                        return matchingItem.city == placemark.city
                    }) {
                        matchingItems.append(placemark)
                    }
                }
                self.matchingItems = matchingItems
                self.tableView.reloadData()
            }else{
                self.tableView.reloadData()
            }
            
        }
    }
}
