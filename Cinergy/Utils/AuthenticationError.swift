//
//  AuthenticationError.swift
//  Cinergy
//
//  Created by Jinu on 28/08/2024.
//

import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}
