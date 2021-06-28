//
//  Fampay_assignmentApp.swift
//  Fampay assignment
//
//  Created by Waseem Akram on 26/06/21.
//

import SwiftUI

@main
struct Fampay_assignmentApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
