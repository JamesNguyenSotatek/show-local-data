//
//  Object+Extension.swift
//  show-local-data
//
//  Created by James on 06/12/2023.
//

import Foundation

extension NSObject {
    
    class var className: String {
        return String(describing: self)
    }
    
}
