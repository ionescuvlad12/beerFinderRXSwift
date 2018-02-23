//
//  Beer+Mapping.swift
 
//
//  Created by Vlad Ionescu on 23.02.18.
//  Copyright © 2018 Ionescu. All rights reserved.
//

import Domain
import ObjectMapper

extension Beer: ImmutableMappable, Identifiable {

    // JSON -> Object
    public init(map: Map) throws {
        beerDescription = try map.value("description")
        name = try map.value("name")
        imgURL = try map.value("image_url")
        tagline = try map.value("tagline")
        abv = try map.value("abv")
    }
}

extension Beer: Encodable {
    var encoder: NETBeer {
        return NETBeer(with: self)
    }
}

final class NETBeer: NSObject, NSCoding, DomainConvertibleType {
    struct Keys {
        static let beerDescription = "description"
        static let name = "name"
        static let imgURL = "tagline"
        static let tagline = "image_url"
        static let abv = "abv"
    }
    let beerDescription: String
    let name: String
    let imgURL: String
    let tagline: String
    let abv: NSNumber

    init(with domain: Beer) {
        self.beerDescription = domain.beerDescription
        self.name = domain.name
        self.imgURL = domain.imgURL
        self.tagline = domain.tagline
        self.abv = domain.abv
    }
    
    init?(coder aDecoder: NSCoder) {
        guard
            let beerDescription = aDecoder.decodeObject(forKey: Keys.beerDescription) as? String,
            let name = aDecoder.decodeObject(forKey: Keys.name) as? String,
            let imgURL = aDecoder.decodeObject(forKey: Keys.imgURL) as? String,
            let tagline = aDecoder.decodeObject(forKey: Keys.tagline) as? String,
            let abv = aDecoder.decodeObject(forKey: Keys.abv) as? NSNumber
        else {
            return nil
        }
        self.beerDescription = beerDescription
        self.name = name
        self.imgURL = imgURL
        self.tagline = tagline
        self.abv = abv
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(beerDescription, forKey: Keys.beerDescription)
        aCoder.encode(name, forKey: Keys.name)
        aCoder.encode(imgURL, forKey: Keys.imgURL)
        aCoder.encode(tagline, forKey: Keys.tagline)
        aCoder.encode(abv, forKey: Keys.abv)
    }
    
    func asDomain() -> Beer {
        return Beer(beerDescription: beerDescription,
                    name: name,
                    imgURL: imgURL,
                    tagline: tagline,
                    abv: abv)
    }
}
