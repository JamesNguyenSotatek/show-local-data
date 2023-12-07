//
//  LocalDataType.swift
//  show-local-data
//
//  Created by James on 06/12/2023.
//

import Foundation

enum LocalDataType: CustomStringConvertible {
    case userDefaults(item: UserDefaultType)
    case keychain(item: KeychainType)
    
    var description: String {
        switch self {
        case .userDefaults:
            return "UserDefaults \(name)"
        case .keychain:
            return "Keychain \(name)"
        }
    }
    
    var name: String {
        switch self {
        case .userDefaults(let item):
            return item.name
        case .keychain(let item):
            return item.name
        }
    }
    
    var items: [DetailValue] {
        switch self {
        case .userDefaults(let _item):
            return _item.items
        case .keychain(let _item):
            return _item.items
        }
    }
}

enum UserDefaultType {
    case standard(items: [DetailValue])
    case suiteName(name: String, items: [DetailValue])
    
    var items: [DetailValue] {
        switch self {
        case .standard(let items):
            return items
        case let .suiteName(_ , items):
            return items
        }
    }
    
    var name: String {
        switch self {
        case .standard:
            return "Standard"
        case let .suiteName(name, _):
            return name
        }
    }
}

enum KeychainType {
    case service(name: String, items: [DetailValue])
    
    var items: [DetailValue] {
        switch self {
        case let .service(_, items):
            return items
        }
    }
    
    var name: String {
        switch self {
        case let .service(name, _):
            return name
        }
    }
}
