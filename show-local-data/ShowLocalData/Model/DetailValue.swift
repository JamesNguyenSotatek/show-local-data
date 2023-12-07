//
//  DetailValue.swift
//  show-local-data
//
//  Created by James on 06/12/2023.
//

import Foundation

struct DetailValue {
    var key: String
    var value: Any
    
    var displayText: String {
        return "\(key) : \(value)"
    }
}
