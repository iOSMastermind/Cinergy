//
//  ContentView.swift
//  Cinergy
//
//  Created by Jinu on 24/08/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        if authViewModel.isAuthenticated {
            if let user = authViewModel.currentUser {
                
                // Create an instance of FeedViewModel
                let requestService = RequestServices() // Assuming this conforms to RequestServiceProtocol
                let feedViewModel = FeedViewModel(requestService: requestService)
                
                MainView(viewModel: feedViewModel, user: user)
           
            }
        } else {
            WelcomeView()
        }
    }
}

