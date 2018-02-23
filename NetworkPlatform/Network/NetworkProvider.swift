//
//  NetworkProvider.swift
 
//
//  Created by Vlad Ionescu on 23.02.18.
//  Copyright © 2018 Ionescu. All rights reserved.
//

import Domain

final class NetworkProvider {
    private let apiEndpoint: String

    public init() {
        apiEndpoint = "https://api.punkapi.com/v2/"
    }


    public func makeBeersNetwork() -> BeersNetwork {
        let network = Network<Beer>(apiEndpoint)
        return BeersNetwork(network: network)
    }
}
