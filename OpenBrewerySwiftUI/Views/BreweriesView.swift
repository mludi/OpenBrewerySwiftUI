//
//  ContentView.swift
//  OpenBrewerySwiftUI
//
//  Created by Matthias Ludwig
//

import SwiftUI
import Combine

struct BreweriesView: View {
    @ObservedObject var viewModel = BreweriesViewModel()

    var body: some View {
        NavigationView {
            Group {
                if let errorMessage = viewModel.errorMessage {
                    ErrorView(errorMessage: errorMessage)
                } else {
                    List(viewModel.breweries, id: \.self) { brewery in
                        NavigationLink(destination: BreweryDetailView(brewery: brewery)) {
                            BreweryRow(brewery: brewery)
                        }
                    }
                }
            }
            .navigationBarTitle("Breweries")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                self.viewModel.fetchBreweries()
            }
        }
    }
}

struct BreweriesView_Previews: PreviewProvider {
    static var previews: some View {
        BreweriesView()
    }
}
