//
//  Movie.swift
//  Cinergy
//
//  Created by Jinu on 25/08/2024.
//

import Foundation

struct Movie: Codable, Identifiable {
    public let id: UUID = UUID() // Automatically generates a unique ID
    let response: String
    let er_Tickets: String?
    let escapeRoomsMovies: [EscapeRoom]

    enum CodingKeys: String, CodingKey {
        case response
        case er_Tickets = "er_Tickets"
        case escapeRoomsMovies = "escape_rooms_movies"
    }
}

public struct EscapeRoom: Codable, Identifiable {
    public var id: String // Ensure id is available for Identifiable
    let scheduledFilmId: String
    let slug: String
    let title: String
    let rating: String
    let runTime: String
    let synopsis: String
    let imageUrl: String
    let imageUrlPoster: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case scheduledFilmId = "ScheduledFilmId"
        case slug
        case title = "Title"
        case rating = "Rating"
        case runTime = "RunTime"
        case synopsis = "Synopsis"
        case imageUrl = "image_url"
        case imageUrlPoster = "image_url_poster"
    }
}
