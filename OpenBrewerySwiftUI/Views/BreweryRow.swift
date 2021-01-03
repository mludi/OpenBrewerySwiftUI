//
//  BreweryRow.swift
//  OpenBrewerySwiftUI
//
//  Created by Matthias Ludwig
//

import SwiftUI

struct BreweryRow: View {
    private let brewery: Brewery

    @State private var showMapView = false
    @State private var showSafariView = false

    init(brewery: Brewery) {
        self.brewery = brewery
    }

    var body: some View {
        HStack {
            if let image = UIImage(named: "beer") {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }

            VStack(alignment: .leading) {
                Text(brewery.name)
                    .font(.system(size: 18))

                Spacer()

                Text("Type: \(brewery.breweryType.rawValue)")
                    .font(.system(size: 14))
                Text("\(brewery.city) - \(brewery.street)")
                    .font(.system(size: 12))

                Spacer()

                HStack {
                    if let url = URL(string: brewery.websiteUrl) {
                        Button("Visit") {
                            self.showSafariView.toggle()
                        }
                        .foregroundColor(.blue)
                        .sheet(isPresented: $showSafariView) {
                            SafariView(url: url)
                        }
                    } else {
                        Text("Visit")
                            .foregroundColor(.gray)
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
    }

}

struct BreweryRow_Previews: PreviewProvider {
    static var previews: some View {
        BreweryRow(brewery: Brewery.demoData)
    }
}
