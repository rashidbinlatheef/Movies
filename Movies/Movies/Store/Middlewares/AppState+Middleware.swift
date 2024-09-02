//
//  AppState+Middleware.swift
//  Movies
//
//  Created by Muhammed Rashid on 02/09/24.
//

import Foundation

extension AppState {
    enum Middleware {}
}

extension AppState {
    static let middleware = CompositeMiddleware<AppState, AppAction>(
        AppState.Middleware.counterMiddleware.middleware
    )
}
