//
//  CitiesViewController.swift
//  WeatherApp
//
//  Created by maksim_p on 16.02.2018.
//  Copyright © 2018 maksim_p. All rights reserved.
//

import UIKit

class CitiesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var cities: [City]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: String(describing: WeatherCityTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: WeatherCityTableViewCell.self))
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updatingData()
    }
    
    @IBAction func SearchButtonPressed(_ sender: Any) {
        
        if InternetCheck.isConnectedToNetwork() {
            performSegue(withIdentifier: "searchSeque", sender: nil)
        }else {
            showMessage("No Internet")
        }
    }
    
    func updatingData() {
        
        self.cities = CoreDataManager.instance.fetchAllCities()?.reversed()
        tableView.reloadData()
    }
}

extension CitiesViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WeatherCityTableViewCell.self), for: indexPath) as! WeatherCityTableViewCell
        if let city = cities, let cityName = city[indexPath.row].name {
            cell.configure(cityName, isDaily: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let city = cities, let cityName = city[indexPath.row].name else {
            return
        }
        
        if InternetCheck.isConnectedToNetwork() {
            let selectedItem = cityName
            let viewController = DetailsWeatherTableViewController()
            viewController.nameCity = selectedItem
            navigationController?.pushViewController(viewController, animated: true)
        }else {
            showMessage("No Internet")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
}
