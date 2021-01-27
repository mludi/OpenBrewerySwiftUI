//
//  ContentView.swift
//  OpenBrewerySwiftUI
//
//  Created by Matthias Ludwig
//

import SwiftUI
import Combine

struct SearchBreweries: View {
    @StateObject var viewModel = BreweriesViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your query", text: $viewModel.searchQuery, onCommit: {
                    viewModel.searchBreweries(viewModel.searchQuery)
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .autocapitalization(.none)
                .disableAutocorrection(true)

                if let errorMessage = viewModel.errorMessage {
                    ErrorView(errorMessage: errorMessage)
                } else {
                    List(viewModel.breweries, id: \.self) { brewery in
                        BreweryRow(brewery: brewery)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationBarTitle("Breweries")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SearchBreweries_Previews: PreviewProvider {
    static var previews: some View {
        BreweriesView()
    }
}
