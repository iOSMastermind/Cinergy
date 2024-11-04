//
//  MainView.swift
//  Cinergy
//
//  Created by Jinu on 25/08/2024.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: FeedViewModel
    let user: User

    init(viewModel: FeedViewModel, user: User) {
        self.viewModel = viewModel
        self.user = user
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 18) {
                FeedView(viewModel: viewModel, user: user)
            }
        }
    }
}
