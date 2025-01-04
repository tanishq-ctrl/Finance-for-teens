//
//  Finance_for_TeensApp.swift
//  Finance for Teens
//
//  Created by Tanishq Prabhu on 03/01/2025.
//

import SwiftUI

@main
struct Finance_for_TeensApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
