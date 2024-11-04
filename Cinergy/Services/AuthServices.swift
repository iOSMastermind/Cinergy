//
//  AuthServices.swift
//  Cinergy
//
//  Created by Jinu on 24/08/2024.
//

import Foundation

 class AuthServices: AuthServiceProtocol {
    public static var requestDomain = ""
    public static var baseURLString = Constants.Urls.baseURL
    public static let apiEndPoint: ApiEndPoints = .guestToken

     func guestLogin(completion: @escaping (Result<Data?, AuthenticationError>) -> Void) {
        guard let baseURL = URL(string: Self.baseURLString),
              let url = URL(string: Self.apiEndPoint.path, relativeTo: baseURL) else {
                completion(.failure(.custom(errorMessage: "Invalid URL")))
                return
        }

        let parameters: [String: Any] = [
            "secret_key": Constants.Urls.secretKey,
            "device_type": Constants.Urls.deviceType,
            "device_id": Constants.Urls.devicId,
            "push_token": ""
        ]

        makeRequest(url: url, reqBody: parameters) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(.custom(errorMessage: error.localizedDescription)))
            }
        }
    }

    private func makeRequest(url: URL, reqBody: [String: Any], completion: @escaping (_ result: Result<Data?, NetworkError>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: reqBody, options: .prettyPrinted)
        } catch {
            print("Error serializing JSON: \(error.localizedDescription)")
            completion(.failure(.decodingError))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                completion(.failure(.noData))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            // Assuming that the data is valid JSON; update according to your response format
            do {
                _ = try JSONSerialization.jsonObject(with: data, options: [])
                completion(.success(data))
            } catch {
                completion(.failure(.decodingError))
            }
        }

        task.resume()
    }
}
