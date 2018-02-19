//
//  City+CoreDataProperties.swift
//  
//
//  Created by maksim_p on 12.12.2017.
//
//

import Foundation
import CoreData


extension City {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City");
    }
    
    @NSManaged public var name: String?
}
