//
//  NetworkError.swift
//  Cinergy
//
//  Created by Jinu on 28/08/2024.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case noData
    case decodingError
    case custom(errorMessage: String)
}
