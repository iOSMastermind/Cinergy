//
//  ApiEndPoints.swift
//  Cinergy
//
//  Created by Jinu on 24/08/2024.
//

import Foundation


public enum ApiEndPoints  {
    case guestToken
    case login
    case escapeRoomMovies
    case getMovieInfo
}

extension ApiEndPoints {
    var path: String {
        switch self {
        case .guestToken:
            return "api/guestToken"
        case .login:
            return "api/login"
        case .escapeRoomMovies:
            return "api/escapeRoomMovies"
        case .getMovieInfo:
            return "api/getMovieInfo"
        }
    }
}
