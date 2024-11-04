//
//  MovieBookingViewModel.swift
//  Cinergy
//
//  Created by Jinu on 26/08/2024.
//

import Foundation
import Combine

class MovieBookingViewModel: ObservableObject {
    var movie: EscapeRoom
    @Published var movieDetail: MovieDetail?
    @Published var selectedDate: String? {
        didSet {
            updateAvailableTimes()
        }
    }
    @Published var availableTimes: [String] = []
    @Published var user: User?

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM dd" // "Mon Aug 06"
        return formatter
    }()
    
    private let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE" // "Mon Aug 06"
        return formatter
    }()
    
    private let monthAndDayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd" // "Mon Aug 06"
        return formatter
    }()
    
    private let requestService: RequestServiceProtocol
    
    init(movie: EscapeRoom, user: User, requestService: RequestServiceProtocol) {
        self.movie = movie
        self.user = user
        self.movieDetail = nil
        self.requestService = requestService
        fetchMovieDetails()
    }
    
    func fetchMovieDetails() {
        let parameters: [String: Any] = [
            "device_type": Constants.Urls.deviceType,
            "device_id": Constants.Urls.devicId,
            "location_id": Constants.Urls.locationId,
            "movie_id": self.movie.id,
            "push_token": ""
        ]
        RequestServices.apiEndPoint = .getMovieInfo
       
        requestService.fetchData(parameters: parameters) { [weak self] result in
            switch result {
            case .success(let data):
                guard let data = data else { return }

                do {
                    let movie = try JSONDecoder().decode(MovieDetail.self, from: data)
                    DispatchQueue.main.async {
                        self?.movieDetail = movie
                        if let firstDate = movie.movieInfo?.dateList.first {
                            self?.selectedDate = firstDate
                        }
                    }
                } catch {
                    print("Decoding error: \(error)")
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func updateAvailableTimes() {
        guard let date = selectedDate, let showTimes = movieDetail?.movieInfo?.showTimes else {
            availableTimes = []
            return
        }
        
        if let selectedShowTime = showTimes.first(where: { $0.date == date }) {
            availableTimes = selectedShowTime.sessions.map { $0.showtime }
        } else {
            availableTimes = []
        }
    }
    
    func formattedDate(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Assuming your dateString is in this format
        if let date = dateFormatter.date(from: dateString) {
            return self.dayFormatter.string(from: date)
        }
        return dateString
    }
    
    func dayOfWeek(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Day of the week (e.g., "Mon")
        if let date = dateFormatter.date(from: dateString) {
            return self.dateFormatter.string(from: date)
        }
        return dateString
    }

    func monthAndDay(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Month and day (e.g., "Aug 26")
        if let date = dateFormatter.date(from: dateString) {
            return self.monthAndDayFormatter.string(from: date)
        }
        return dateString
    }
}

