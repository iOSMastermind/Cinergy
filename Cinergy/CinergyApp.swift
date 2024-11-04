//
//  CinergyApp.swift
//  Cinergy
//
//  Created by Jinu on 24/08/2024.
//

import SwiftUI

@main
struct CinergyApp: App {
    // Create an instance of AuthServices
    private var authService: AuthServiceProtocol = AuthServices()
    // Create an instance of AuthViewModel, injecting the service
    private var authViewModel: AuthViewModel

    init() {
        authViewModel = AuthViewModel(authService: authService)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel) // Provide the view model as an environment object
        }
    }
}
