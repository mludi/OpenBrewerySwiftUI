//
//  OpenBrewerySwiftUIApp.swift
//  OpenBrewerySwiftUI
//
//  Created by Matthias Ludwig
//

import SwiftUI

@main
struct OpenBrewerySwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            TabView {
                BreweriesView()
                    .tabItem {
                        Image(systemName: "tray.2")
                        Text("Breweries")
                    }
                SearchBreweries()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
            }
        }
    }
}
