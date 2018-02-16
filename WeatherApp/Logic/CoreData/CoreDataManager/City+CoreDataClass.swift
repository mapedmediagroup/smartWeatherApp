//
//  City+CoreDataClass.swift
//  
//
//  Created by maksim_p on 12.12.2017.
//
//

import Foundation
import CoreData


public class City: NSManagedObject {
    
    convenience init() {
        
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "City"), insertInto: CoreDataManager.instance.managedObjectContext)
    }
}
