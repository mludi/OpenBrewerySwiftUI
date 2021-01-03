//
//  ErrorView.swift
//  OpenBrewerySwiftUI
//
//  Created by Matthias Ludwig
//

import SwiftUI

struct ErrorView: View {
    private let errorMessage: String

    init(errorMessage: String) {
        self.errorMessage = errorMessage
    }

    var body: some View {
        Text(errorMessage)
    }
}
