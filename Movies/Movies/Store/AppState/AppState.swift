//
//  AppState.swift
//  Movies
//
//  Created by Muhammed Rashid on 02/09/24.
//

import Foundation

struct AppState {
    var movies: [Movie]
}

extension AppState: Defaultable {
    static let defaultValue = AppState(movies: [])
}

extension AppState {
    static let reducer = CompositeReducer<AppState, AppAction>(
       
    )
}

protocol Defaultable {
    static var defaultValue: Self { get }
}
