//
//  CDBeer+CoreDataClass.swift
//  NetworkAndSecurity
//
//  Created by Ionescu on 23/02/2018.
//  Copyright © 2018 Ionescu. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData
import Domain
import QueryKit
import RxSwift

extension CDBeer {
    static var name: Attribute<String> { return Attribute("name")}
    static var beerDescription: Attribute<String> { return Attribute("description")}
    static var tagline: Attribute<String> { return Attribute("tagline")}
    static var imgURL: Attribute<String> { return Attribute("imgURL")}
    static var abv: Attribute<NSNumber> { return Attribute("abv")}
}

extension CDBeer: DomainConvertibleType {
    func asDomain() -> Beer {
        return Beer(beerDescription: beerDescription!,
                    name: name!,
                    imgURL: imgURL!,
                    tagline: tagline!,
                    abv: abv!)
    }
}

extension CDBeer: Persistable {
    static var entityName: String {
        return "CDBeer"
    }
}

extension Beer: CoreDataRepresentable {
    typealias CoreDataType = CDBeer
    
    func update(entity: CDBeer) {
        entity.imgURL = imgURL
        entity.name = name
        entity.beerDescription = beerDescription
        entity.tagline = tagline
        entity.abv = abv
    }
}
