//
//  ContentView.swift
//  Movies
//
//  Created by Muhammed Rashid on 02/09/24.
//

import SwiftUI

struct ContentView: View, Props {
    @StateObject var interactor: CounterInteractor
    
    @State var props: Props
    
    struct Props: Defaultable {
        static var defaultValue: ContentView.Props = .init(counter: "0", update: nil)
        
        let counter: String
        let update: ((Int) -> Void)?
    }
    
    var body: some View {
        VStack {
            Text("\(props.counter)")
            Button {
                props.update?(4)
            } label: {
                Text("Increment Counter")
            }
        }
        .padding()
        .onAppear{
            props = interactor.props
        }
        .onReceive(interactor.$props) { newProps in
            props = newProps
        }
    }
}

#Preview {
    ContentView(interactor: .init(store: .init(store: .init(state: .defaultValue,
                                                            reducer: AppState.reducer,
                                                            middleware: .init(AppState.middleware)))), 
                props: .defaultValue)
}
