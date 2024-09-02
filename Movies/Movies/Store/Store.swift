//
//  Store.swift
//  Movies
//
//  Created by Muhammed Rashid on 02/09/24.
//

import Foundation

typealias Dispatcher = (Action) -> Void

typealias Reducer<State: ReduxState> = (_ state: State, _ action: Action) -> State
typealias Middleware<StoreState: ReduxState> = (StoreState, Action, @escaping Dispatcher) -> Void

protocol ReduxState {}

struct AppState: ReduxState {
    
}

protocol Action {}

class Store<StoreState: ReduxState>: ObservableObject {
    var reducer: Reducer<StoreState>
    @Published var state: StoreState
    var middlewares: [Middleware<StoreState>]
    
    init(reducer: @escaping Reducer<StoreState>,
         state: StoreState,
         middlewares: [Middleware<StoreState>] = []) {
        self.reducer = reducer
        self.state = state
        self.middlewares = middlewares
    }
    
    func dispatch(action: Action) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.state = self.reducer(self.state, action)
        }
        middlewares.forEach { middleware in
            middleware(state, action, dispatch)
        }
    }
}
