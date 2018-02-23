//
//  UseCaseProvider.swift
 
//
//  Created by Ionescu on 23/02/2018.
//  Copyright © 2018 Ionescu. All rights reserved.
//

import Foundation

public protocol UseCaseProvider {
    func makeBeersUseCase() -> BeersUseCase
}
