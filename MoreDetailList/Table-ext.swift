//
//  Table-ext.swift
//  MoreDetailList
//
//  Created by 박형환 on 2022/10/01.
//

import Foundation
import UIKit


protocol Identifiable{
    static var identify: String {get}
}
extension Identifiable{
    static var identify: String {
        return String(describing: Self.self)
    }
}

extension TableViewCell: Identifiable{
    
}

