//  /*
//
//  Project: SwiftDataEx
//  File: SwiftDataExApp.swift
//  Created by: Elaidzha Shchukin
//  Date: 10.01.2024
//
//  */

import SwiftUI
import SwiftData

@main
struct SwiftDataExApp: App {
    
//    let container: ModelContainer = {
//        let schema = Schema([MyExpense.self])
//        let container = try! ModelContainer(for: schema, configurations: [])
//        return container
//    }()
    
    var body: some Scene {
        WindowGroup {
            SwiftDataEx()
        }
        //.modelContainer(container)
        .modelContainer(for: [MyExpense.self])
    }
}
