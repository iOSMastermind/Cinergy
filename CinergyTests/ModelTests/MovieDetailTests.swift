//
//  MovieDetailTests.swift
//  CinergyTests
//
//  Created by Jinu on 28/08/2024.
//

import XCTest
@testable import Cinergy

class MovieDetailTests: XCTestCase {

    func testMovieDetailEncodingAndDecoding() {
        // Create sample sessions
        let session1 = Session(
            scheduledFilmId: "SF123",
            attribute: "3D",
            sessionId: "S123",
            showtimeVista: "Vista123",
            showtime: "2023-08-28T20:00:00",
            isAllocatedSeating: true,
            seatsAvailable: 50,
            screenNumber: 5,
            soldoutStatus: 0,
            allowTicketSales: true
        )

        let session2 = Session(
            scheduledFilmId: "SF124",
            attribute: "2D",
            sessionId: "S124",
            showtimeVista: "Vista124",
            showtime: "2023-08-28T22:00:00",
            isAllocatedSeating: false,
            seatsAvailable: 30,
            screenNumber: 3,
            soldoutStatus: 0,
            allowTicketSales: true
        )

        // Create sample showtimes
        let showTime1 = ShowTime(
            date: "2023-08-28",
            sessions: [session1, session2]
        )

        // Create sample MovieInfo
        let movieInfo = MovieInfo(
            scheduledFilmId: "SF123",
            slug: "movie-slug",
            title: "Test Movie",
            rating: "PG-13",
            runTime: "120 min",
            synopsis: "A test movie synopsis.",
            imageURL: "http://example.com/movie.jpg",
            imageURLPoster: "http://example.com/movie-poster.jpg",
            trailerURL: "http://example.com/trailer.mp4",
            genres: "Action, Adventure",
            showTimes: [showTime1],
            dateList: ["2023-08-28", "2023-08-29"]
        )

        // Create sample MovieDetail
        let movieDetail = MovieDetail(
            response: "Success",
            movieInfo: movieInfo,
            erTickets: "Available"
        )

        // Encode and then decode the MovieDetail
        do {
            let jsonData = try JSONEncoder().encode(movieDetail)
            let decodedMovieDetail = try JSONDecoder().decode(MovieDetail.self, from: jsonData)

            // Assert the decoded values
            XCTAssertEqual(decodedMovieDetail.response, "Success")
            XCTAssertEqual(decodedMovieDetail.erTickets, "Available")

            if let decodedMovieInfo = decodedMovieDetail.movieInfo {
                XCTAssertEqual(decodedMovieInfo.title, "Test Movie")
                XCTAssertEqual(decodedMovieInfo.imageURL, "http://example.com/movie.jpg")
                XCTAssertEqual(decodedMovieInfo.showTimes.count, 1)

                if let decodedShowTime = decodedMovieInfo.showTimes.first {
                    XCTAssertEqual(decodedShowTime.date, "2023-08-28")
                    XCTAssertEqual(decodedShowTime.sessions.count, 2)

                    if let decodedSession = decodedShowTime.sessions.first {
                        XCTAssertEqual(decodedSession.scheduledFilmId, "SF123")
                        XCTAssertEqual(decodedSession.showtime, "2023-08-28T20:00:00")
                    }
                }
            } else {
                XCTFail("movieInfo is nil")
            }

        } catch {
            XCTFail("Encoding/Decoding failed: \(error)")
        }
    }
}
