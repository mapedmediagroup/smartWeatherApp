//
//  CoreDataProvider.swift
//  WeatherApp
//
//  Created by maksim_p on 12.12.2017.
//  Copyright © 2017 maksim_p. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataProvider{
    
    let fetchRequest = NSFetchRequest<City>(entityName: "City")
    
    static func isCityExistInCoreData(cityNameString:String) -> Bool{
        
        let predicate = NSPredicate(format: "name == %@ ", cityNameString)
        let fetchRequest = NSFetchRequest<City>(entityName: "City")
        fetchRequest.predicate = predicate
        if try! CoreDataManager.instance.managedObjectContext.fetch(fetchRequest).count > 0 {
            return true
        }else{
            return false
        }
    }
    
    static func saveCityToCoreData(city: String, completion: @escaping ()->Void ){
        let cityObject = City(context: CoreDataManager.instance.managedObjectContext)
        if cityObject == cityObject {
            cityObject.name = city
            CoreDataManager.instance.saveContext()
            completion()
        }
    }
}
