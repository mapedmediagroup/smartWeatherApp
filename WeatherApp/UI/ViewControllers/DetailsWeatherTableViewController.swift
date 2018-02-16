//
//  DetailsWeatherTableViewController.swift
//  WeatherApp
//
//  Created by maksim_p on 11.12.2017.
//  Copyright © 2017 maksim_p. All rights reserved.
//

import UIKit

class DetailsWeatherTableViewController: UITableViewController {
    
    var nameCity : String = ""
    var citiesRequest = APIProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSaveButton()
        navigationItem.title = nameCity
        citiesRequest.getForecastWeather(nameCity) {
            self.tableView.reloadData()
        }
        tableView.register(UINib(nibName: String(describing: WeatherCityTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: WeatherCityTableViewCell.self))
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
    }
    
    func addSaveButton() {
        if !CoreDataProvider.isCityExistInCoreData(cityNameString: nameCity) {
            let saveButton = UIButton(type: .custom)
            saveButton.setTitle("Save", for: .normal)
            saveButton.setTitleColor(saveButton.tintColor, for: .normal) // You can change the TitleColor
            saveButton.addTarget(self, action: #selector(self.addSaveButton(_:)), for: .touchUpInside)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
        }
        
    }
    
    @IBAction func addSaveButton(_ sender: UIButton) {
        
        CoreDataProvider.saveCityToCoreData(city: nameCity, completion: {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            _ = self.navigationController?.popViewController(animated: true)
        })
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return citiesRequest.detailsWeather.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WeatherCityTableViewCell.self), for: indexPath) as! WeatherCityTableViewCell
        cell.configure(isDaily: false, detail: citiesRequest.detailsWeather[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
}
