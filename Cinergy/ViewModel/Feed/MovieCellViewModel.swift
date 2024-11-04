//
//  MovieCellViewModel.swift
//  Cinergy
//
//  Created by Jinu on 25/08/2024.
//

import Foundation
class MovieCellViewModel: ObservableObject {
    @Published var  escapeRoomsMovie: EscapeRoom
    @Published var user: User?
    
    init(escapeRoomsMovie: EscapeRoom, user: User) {
        self.escapeRoomsMovie = escapeRoomsMovie
        self.user = user
    }

}
