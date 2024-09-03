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
                                                              reducer: AppState.reducer,
                                                              middleware: .init(AppState.middleware))
    )
    
    var body: some Scene {
        WindowGroup {
            ContentView(interactor: .init(store: appStore), props: .defaultValue)
                .environmentObject(appStore)
                .environmentObject(Router())
        }
    }
}
