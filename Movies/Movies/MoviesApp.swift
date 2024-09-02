//
//  MoviesApp.swift
//  Movies
//
//  Created by Muhammed Rashid on 02/09/24.
//

import SwiftUI

@main
struct MoviesApp: App {
    @StateObject private var appStore = AppStore(store: .init(state: .defaultValue,
                                                              reducer: AppState.reducer.reduce,
                                                              middleware: .init(AppState.middleware.middleware))
    )
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appStore)
        }
    }
}
