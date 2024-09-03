//
//  CounterInteractor.swift
//  Movies
//
//  Created by Muhammed Rashid on 02/09/24.
//

import Foundation

class CounterInteractor: AppInteractor<ContentView> {
    
    override func map(state: AppState) -> ContentView.Props {
        let counterState = state.counter
        let counterValue = counterState.count
        return .init(counter: "\(counterValue)") { [weak self] offSet in
            self?.store.dispatch(UpdateCounter(offSet: offSet))
        }
    }
}
