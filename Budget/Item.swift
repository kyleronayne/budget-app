//
//  Item.swift
//  Budget
//
//  Created by Kyle Ronayne on 12/28/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
