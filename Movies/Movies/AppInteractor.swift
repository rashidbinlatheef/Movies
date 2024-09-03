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

final class Router: ObservableObject {
    enum Route: Hashable {
        case detail
    }
    
    @Published var path = NavigationPath()
    
    func view(for path: Route) -> some View {
        switch path {
        case .detail:
            return DetailView()
        }
    }
    
    // Used by views to navigate to another view
    func navigateTo(_ route: Route) {
        path.append(route)
    }
    
    // Used to go back to the previous screen
    func navigateBack() {
        path.removeLast()
    }
    
    // Pop to the root screen in our hierarchy
    func popToRoot() {
        path.removeLast(path.count)
    }
}
