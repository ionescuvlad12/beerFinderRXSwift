//
//  BeersNetwork.swift
 
//
//  Created by Vlad Ionescu on 23.02.18.
//  Copyright © 2018 Ionescu. All rights reserved.
//

import Domain
import RxSwift

public final class BeersNetwork {
    private let network: Network<Beer>

    init(network: Network<Beer>) {
        self.network = network
    }

    public func fetchBeers() -> Observable<[Beer]> {
        return network.getItems("beers")
    }

    public func fetchBeer(food: String) -> Observable<[Beer]> {
        return network.getItems("beers?food=_\(food)")
    }
}
