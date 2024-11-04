//
//  AuthServiceProtocol.swift
//  Cinergy
//
//  Created by Jinu on 28/08/2024.
//

import Foundation

 protocol AuthServiceProtocol {
    func guestLogin(completion: @escaping (Result<Data?, AuthenticationError>) -> Void)
}
