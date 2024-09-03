//
//  AppInteractor.swift
//  Movies
//
//  Created by Muhammed Rashid on 02/09/24.
//

import Combine
import Foundation
import SwiftUI

protocol Props {
    associatedtype Props: Defaultable
    var props: Props { get }
}

class AppInteractor<ViewType: Props>: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    let store: AppStore
    @Published var props: ViewType.Props = .defaultValue // Published props that will update the view
    
    init(store: AppStore) {
        // Observe changes in the AppStore and update props accordingly
        self.store = store
        store.$state
            .sink { [weak self] state in
                self?.props = self?.map(state: state) ?? .defaultValue
            }
            .store(in: &cancellables)
    }
    
    // A method to build props from a given app state
    open func map(state: AppState) -> ViewType.Props {
        .defaultValue
    }
}
