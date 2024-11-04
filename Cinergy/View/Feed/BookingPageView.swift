//
//  BookingPageView.swift
//  Cinergy
//
//  Created by Jinu on 26/08/2024.
//

import SwiftUI

struct BookingPageView: View {
    @ObservedObject var viewModel : MovieBookingViewModel
    init(viewModel: MovieBookingViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

