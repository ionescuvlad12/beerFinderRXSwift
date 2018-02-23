//
//  UidTransform.swift
 
//
//  Created by Vlad Ionescu on 23.02.18.
//  Copyright © 2018 Ionescu. All rights reserved.
//

import ObjectMapper

class UidTransform: TransformType {

    typealias Object = String
    typealias JSON = Int
    
    init() {}
    
    func transformFromJSON(_ value: Any?) -> String? {
        if let imgURLInt = value as? Int {
            return String(imgURLInt)
        }
        
        if let imgURLStr = value as? String {
            return imgURLStr
        }
        
        return nil
    }
    
    func transformToJSON(_ value: String?) -> Int? {
        if let imgURL = value {
            return Int(imgURL)
        }
        return nil
    }
}
