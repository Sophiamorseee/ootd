//
//  ootdApp.swift
//  ootd
//
//  Created by Sophia Morse on 5/10/24.
//

import SwiftUI

@main
struct ootdApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
