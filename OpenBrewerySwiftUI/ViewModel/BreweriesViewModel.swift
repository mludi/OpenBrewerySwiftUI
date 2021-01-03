//
//  BreweriesViewModel.swift
//  OpenBrewerySwiftUI
//
//  Created by Matthias Ludwig
//

import Foundation
import Combine

class BreweriesViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()

    @Published private(set) var errorMessage: String?
    @Published var breweries: [Brewery] = []
    @Published var brewery: Brewery?
    @Published var searchQuery = "" {
        didSet {
            guard searchQuery.count >= 3 else {
                return
            }
            searchBreweries()
        }
    }

    let apiClient = APIClient()

    func fetchBreweries() {
        apiClient.fetch(.all)
            .sink { completion in
                if case .failure(let error) = completion,
                   let apiError = error as? APIError {
                    self.errorMessage = apiError.message
                }
            } receiveValue: { (breweries: [Brewery]) in
                self.breweries = breweries
            }.store(in: &cancellables)
    }

    func fetchBrewery(withID id: Brewery.IdentifierType) {
        apiClient.fetch(.brewery(withID: id))
            .sink { completion in
                if case .failure(let error) = completion,
                   let apiError = error as? APIError {
                    self.errorMessage = apiError.message
                }
            } receiveValue: { (brewery: Brewery) in
                self.brewery = brewery
            }.store(in: &cancellables)
    }

    func searchBreweries() {
        apiClient.fetch(.search(for: searchQuery))
            .sink { completion in
                if case .failure(let error) = completion,
                   let apiError = error as? APIError {
                    self.errorMessage = apiError.message
                }
            } receiveValue: { (breweries: [Brewery]) in
                self.breweries = breweries
            }.store(in: &cancellables)
    }
}
