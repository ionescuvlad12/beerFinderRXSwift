//
//  CDBeer+CoreDataProperties.swift
//  
//
//  Created by Vlad Ionescu on 23.02.18.
//
//

import Foundation
import CoreData


extension CDBeer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDBeer> {
        return NSFetchRequest<CDBeer>(entityName: "CDBeer")
    }

    @NSManaged public var beerDescription: String?
    @NSManaged public var name: String?
    @NSManaged public var imgURL: String?
    @NSManaged public var tagline: String?
    @NSManaged public var abv: NSNumber?
}
