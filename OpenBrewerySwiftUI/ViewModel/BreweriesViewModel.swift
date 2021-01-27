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
    @Published var searchQuery = ""

    private let apiClient = APIClient()

    init() {
        $searchQuery
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .filter { $0.count >= 3 }
            .sink { [weak self] query in
                guard let self = self else { return }
                self.searchBreweries(query)
            }
            .store(in: &cancellables)

        $searchQuery
            .dropFirst() // ignore first occurence
            .filter { $0.count < 3 }
            .sink { [weak self ] _ in
                guard let self = self else { return }
                self.breweries = []
            }
            .store(in: &cancellables)
    }

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

    func searchBreweries(_ query: String) {
        apiClient.fetch(.search(for: query))
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
