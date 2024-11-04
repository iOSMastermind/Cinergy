//
//  FeedViewModel.swift
//  Cinergy
//
//  Created by Jinu on 25/08/2024.
//

import Foundation
// FeedViewModel.swift
class FeedViewModel: ObservableObject {
    @Published var escapeRoomsMovies = [EscapeRoom]()
    private var requestService: RequestServiceProtocol

    init(requestService: RequestServiceProtocol) {
        self.requestService = requestService
        fetchFeeds()
    }
    
    func fetchFeeds() {
        RequestServices.apiEndPoint = .escapeRoomMovies
        let parameters: [String: Any] = [
            "secret_key": Constants.Urls.secretKey,
            "device_type": Constants.Urls.deviceType,
            "device_id": Constants.Urls.devicId,
            "location_id": Constants.Urls.locationId,
            "member_id": "\(Constants.Urls.userId ?? 0)",
            "userid": "\(Constants.Urls.userId ?? 0)",
            "push_token": ""
        ]
        requestService.fetchData(parameters: parameters) { [weak self] result in
            switch result {
            case .success(let data):
                guard let data = data else {
                    // Handle the case where `data` is nil
                    return
                }

                do {
                    let movie = try JSONDecoder().decode(Movie.self, from: data)
                    DispatchQueue.main.async {
                        self?.escapeRoomsMovies = movie.escapeRoomsMovies
                    }
                } catch {
                    // Handle the decoding error
                    print("Decoding error: \(error)")
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
