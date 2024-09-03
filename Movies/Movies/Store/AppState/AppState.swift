//
//  AppState.swift
//  Movies
//
//  Created by Muhammed Rashid on 02/09/24.
//

import Foundation

struct AppState {
    var movies: [Movie]
    var counter: Counter
}

extension AppState: Defaultable {
    static let defaultValue = AppState(movies: [], counter: .defaultValue)
}

extension AppState {
    static let reducer = CompositeReducer<AppState, AppAction>(
        PartialReducer<AppState, AppAction>(of: \.counter, Counter.reducer.reduce).reduce
    ).reduce
}

protocol Defaultable {
    static var defaultValue: Self { get }
}
