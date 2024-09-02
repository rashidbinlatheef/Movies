//
//  ContentView.swift
//  Movies
//
//  Created by Muhammed Rashid on 02/09/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appStore: AppStore

    var body: some View {
        VStack {
            Text("\(appStore.state.counter.count)")
            Button {
                appStore.dispatch(UpdateCounter(offSet: 4))
            } label: {
                Text("Increment Counter")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView(appStore: .init())
}
