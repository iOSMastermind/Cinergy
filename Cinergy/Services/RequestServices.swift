//
//  RequestServices.swift
//  Cinergy
//
//  Created by Jinu on 25/08/2024.
//

import Foundation

 class RequestServices: RequestServiceProtocol {
    public static var requestDomain = ""
    public static var baseURLString = Constants.Urls.baseURL
    public static var apiEndPoint: ApiEndPoints = .guestToken

     func fetchData(parameters: [String: Any], completion: @escaping (_ result: Result<Data?, NetworkError>) -> Void) {
        guard let baseURL = URL(string: Self.baseURLString),
              let url = URL(string: Self.apiEndPoint.path, relativeTo: baseURL) else {
            completion(.failure(.invalidUrl))
            return
        }
        
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
            guard let token = UserDefaults.standard.string(forKey: "jsonwebtoken") else {
                print("No token found")
                return
            }
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
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
