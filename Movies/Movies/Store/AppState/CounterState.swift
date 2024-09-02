//
//  CounterState.swift
//  Movies
//
//  Created by Muhammed Rashid on 02/09/24.
//

import Foundation

extension AppState {
    struct Counter {
        var count: Int
    }
}

extension AppState.Counter: Defaultable {
    static let defaultValue = AppState.Counter(count: 0)
}

extension AppState.Counter {
    static let reducer = CompositeReducer<Self, AppAction>(
        updateCounter.reduce
    )
}

private extension AppState.Counter {
    static let updateCounter: TypedReducer<Self, AppAction> = .inout
    { (state, action: UpdateCounter) in
        state.count += action.offSet
    }
}
