//
//  FeedView.swift
//  Cinergy
//
//  Created by Jinu on 25/08/2024.
//

import SwiftUI

struct EscapeRoom1: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
}

struct FeedView: View {
    @ObservedObject var viewModel: FeedViewModel
    let user: User
    @State private var selectedMovie: EscapeRoom? = nil
        @State private var isSheetPresented = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.escapeRoomsMovies) { room in
                    MovieCellView(viewModel: MovieCellViewModel(escapeRoomsMovie: room, user: user))
                        .onTapGesture {
                            selectedMovie = room
                            isSheetPresented = true

                        }
                }
            }
            .padding()
        }
        .sheet(item: $selectedMovie) { movie in
            MovieDetailView(room: movie, user: user)
                       .presentationDetents([.medium/*, .large*/]) // Allows the sheet to be draggable between sizes
                       .presentationDragIndicator(.hidden) // Show the grabber
               }
        
    }
//    func handleCellTap(room: EscapeRoom) {
//           // Handle the tap, e.g., navigate to a detail view, print movie info, etc.
//        MovieDetailView(viewModel: MovieCellViewModel(escapeRoomsMovie: room, user: user))

//       }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
