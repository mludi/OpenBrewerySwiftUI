//
//  BreweryDetailView.swift
//  OpenBrewerySwiftUI
//
//  Created by Matthias Ludwig
//

import SwiftUI

struct BreweryDetailView: View {
    @ObservedObject private var viewModel = BreweriesViewModel()

    private let brewery: Brewery

    init(brewery: Brewery) {
        self.brewery = brewery
    }

    var body: some View {
        Group {
            if let errorMessage = viewModel.errorMessage {
                ErrorView(errorMessage: errorMessage)
            }

            if let fetchedBrewery = viewModel.brewery {
                VStack {
                    if let location = fetchedBrewery.locationCoordinate {
                        MapView(coordinate: location)
                            .ignoresSafeArea(edges: .top)
                            .frame(height: 300)
                    }

                    VStack {
                        Text(fetchedBrewery.name)
                            .font(.title)
                            .padding()
                        Text("Type: \(fetchedBrewery.breweryType.rawValue)")
                            .font(.subheadline)
                            .padding()
                    }
                }

            }
        }
        .onAppear {
            self.viewModel.fetchBrewery(withID: brewery.id)
        }
    }
}

struct BreweryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BreweryDetailView(brewery: Brewery.demoData)
    }
}
