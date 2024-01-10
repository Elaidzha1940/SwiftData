//  /*
//
//  Project: SwiftDataEx
//  File: MyExpense.swift
//  Created by: Elaidzha Shchukin
//  Date: 10.01.2024
//
//  */

import Foundation
import SwiftData

@Model
class MyExpense {
    var name: String
    var date: Date
    var value: Double
    
    init(name: String, date: Date, value: Double) {
        self.name = name
        self.date = date
        self.value = value
    }
}
