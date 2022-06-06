//
//  GameShopApp.swift
//  Shared
//
//  Created by Ashraful Islam Rupu on 5/30/22.
//

import SwiftUI

@main
struct GameShopApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            LogInPageView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
