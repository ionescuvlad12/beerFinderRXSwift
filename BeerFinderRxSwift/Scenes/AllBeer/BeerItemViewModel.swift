//
//  BeerItemViewModel.swift
//
//  Created by Ionescu Vlad on 23/02/18.
//  Copyright © 2018 Ionescu. All rights reserved.
//

import Foundation
import Domain

final class BeerItemViewModel   {
    let title:String
    let subtitle : String
    let tagline : String
    let abv : String
    let beer: Beer
    var imageUrl: String
    
    init (with beer:Beer) {
        self.beer = beer
        self.imageUrl = beer.imgURL
        self.title = beer.name.uppercased()
        self.subtitle = beer.beerDescription
        self.tagline = beer.tagline
        self.abv = "Alchool: \(beer.abv)%"
    }
}
