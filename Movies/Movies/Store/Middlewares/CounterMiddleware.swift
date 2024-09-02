//
//  CounterMiddleware.swift
//  Movies
//
//  Created by Muhammed Rashid on 02/09/24.
//

import Foundation


extension AppState.Middleware {
    static let counterMiddleware = CompositeMiddleware<AppState, AppAction>(
        PartialMiddleware(of: \.counter, updateCounter.middleware).middleware
    )
}

private extension AppState.Middleware {
    static let updateCounter = TypedMiddleware<AppState.Counter, AppAction>(to: UpdateCounter.self)
    { getState, action, next in
        next(action)
    }
}
