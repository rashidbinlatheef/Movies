//
//  AppStore.swift
//  Movies
//
//  Created by Muhammed Rashid on 02/09/24.
//

import Foundation

class AppStore: ObservableObject {
    @Published private(set) var state: AppState
    
    private let store: Store<AppState, AppAction>
    private var cancelObserver: (() -> Void)?

    init(store: Store<AppState, AppAction>) {
        self.store = store
        self.state = store.state
        
        // Observe the state changes and update the @Published state
        self.cancelObserver = store.addObserver { [weak self] newState in
            DispatchQueue.main.async {
                self?.state = newState
            }
        }
    }
    
    func dispatch(_ action: AppAction) {
        store.dispatch(action: action)
    }
    
    deinit {
        // Remove the observer when no longer needed
        cancelObserver?()
    }
}
