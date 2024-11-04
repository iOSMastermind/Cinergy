//
//  RequestServiceProtocol.swift
//  Cinergy
//
//  Created by Jinu on 28/08/2024.
//

import Foundation

 protocol RequestServiceProtocol {
    func fetchData(parameters: [String: Any], completion: @escaping (_ result: Result<Data?, NetworkError>) -> Void)
}
