//
//  ContentView.swift
//  Movies
//
//  Created by Muhammed Rashid on 02/09/24.
//

import SwiftUI

struct ContentView: View, Props {
    @StateObject var interactor: CounterInteractor
    @EnvironmentObject var router: Router
    
    @State var props: Props
    
    struct Props: Defaultable {
        static var defaultValue: ContentView.Props = .init(counter: "0", update: nil)
        
        let counter: String
        let update: ((Int) -> Void)?
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack(spacing: 20) {
                Button {
                    router.navigateTo(.detail)
                } label: {
                    Text("Push Detail")
                }
                
                Button {
                    // TODO: present detail view
                } label: {
                    Text("Present Detail")
                }
            }
            .padding()
            .onAppear{
                props = interactor.props
            }
            .onReceive(interactor.$props) { newProps in
                props = newProps
            }
            .navigationDestination(for: Router.Route.self) { route in
                router.view(for: route)
            }
        }
    }
}

#Preview {
    ContentView(interactor: .init(store: .init(store: .init(state: .defaultValue,
                                                            reducer: AppState.reducer,
                                                            middleware: .init(AppState.middleware)))),
                props: .defaultValue)
}
