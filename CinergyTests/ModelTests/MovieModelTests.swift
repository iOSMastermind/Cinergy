//
//  MovieModelTests.swift
//  CinergyTests
//
//  Created by Jinu on 28/08/2024.
//

import XCTest
@testable import Cinergy

class MovieModelTests: XCTestCase {

    func testMovieDecoding() {
        // Sample JSON data
        let jsonData = """
        {
            "response": "Success",
            "er_Tickets": "Available",
            "escape_rooms_movies": [
                {
                    "ID": "1",
                    "ScheduledFilmId": "SF123",
                    "slug": "escape-room-1",
                    "Title": "Escape Room 1",
                    "Rating": "PG-13",
                    "RunTime": "120 min",
                    "Synopsis": "A thrilling escape room experience.",
                    "image_url": "http://example.com/escape-room-1.jpg",
                    "image_url_poster": "http://example.com/escape-room-1-poster.jpg"
                }
            ]
        }
        """.data(using: .utf8)!
        
        // Decode JSON into Movie model
        do {
            let movie = try JSONDecoder().decode(Movie.self, from: jsonData)
            XCTAssertEqual(movie.response, "Success")
            XCTAssertEqual(movie.er_Tickets, "Available")
            XCTAssertEqual(movie.escapeRoomsMovies.count, 1)
            
            let escapeRoom = movie.escapeRoomsMovies.first
            XCTAssertEqual(escapeRoom?.id, "1")
            XCTAssertEqual(escapeRoom?.scheduledFilmId, "SF123")
            XCTAssertEqual(escapeRoom?.slug, "escape-room-1")
            XCTAssertEqual(escapeRoom?.title, "Escape Room 1")
            XCTAssertEqual(escapeRoom?.rating, "PG-13")
            XCTAssertEqual(escapeRoom?.runTime, "120 min")
            XCTAssertEqual(escapeRoom?.synopsis, "A thrilling escape room experience.")
            XCTAssertEqual(escapeRoom?.imageUrl, "http://example.com/escape-room-1.jpg")
            XCTAssertEqual(escapeRoom?.imageUrlPoster, "http://example.com/escape-room-1-poster.jpg")
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }

    func testMovieEncoding() {
        // Create an EscapeRoom instance
        let escapeRoom = EscapeRoom(
            id: "1",
            scheduledFilmId: "SF123",
            slug: "escape-room-1",
            title: "Escape Room 1",
            rating: "PG-13",
            runTime: "120 min",
            synopsis: "A thrilling escape room experience.",
            imageUrl: "http://example.com/escape-room-1.jpg",
            imageUrlPoster: "http://example.com/escape-room-1-poster.jpg"
        )
        
        // Create a Movie instance
        let movie = Movie(
            response: "Success",
            er_Tickets: "Available",
            escapeRoomsMovies: [escapeRoom]
        )
        
        // Encode Movie model into JSON
        do {
            let jsonData = try JSONEncoder().encode(movie)
            
            // Decode the JSON back to a dictionary for easier comparison
            if let jsonDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
               let escapeRooms = jsonDict["escape_rooms_movies"] as? [[String: Any]],
               let escapeRoomDict = escapeRooms.first {
                
                XCTAssertEqual(jsonDict["response"] as? String, "Success")
                XCTAssertEqual(jsonDict["er_Tickets"] as? String, "Available")
                XCTAssertEqual(escapeRoomDict["image_url"] as? String, "http://example.com/escape-room-1.jpg")
                XCTAssertEqual(escapeRoomDict["image_url_poster"] as? String, "http://example.com/escape-room-1-poster.jpg")
            } else {
                XCTFail("Decoding JSON back to dictionary failed")
            }
        } catch {
            XCTFail("Encoding failed: \(error)")
        }
    }


    func testOptionalValuesHandlingInMovie() {
        // Sample JSON data with missing optional values
        let jsonData = """
        {
            "response": "Success",
            "escape_rooms_movies": []
        }
        """.data(using: .utf8)!
        
        // Decode JSON into Movie model
        do {
            let movie = try JSONDecoder().decode(Movie.self, from: jsonData)
            XCTAssertEqual(movie.response, "Success")
            XCTAssertNil(movie.er_Tickets)
            XCTAssertTrue(movie.escapeRoomsMovies.isEmpty)
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }
    
    func testEscapeRoomDecoding() {
        // Sample JSON data for an EscapeRoom
        let jsonData = """
        {
            "ID": "2",
            "ScheduledFilmId": "SF456",
            "slug": "escape-room-2",
            "Title": "Escape Room 2",
            "Rating": "R",
            "RunTime": "110 min",
            "Synopsis": "Another thrilling escape room experience.",
            "image_url": "http://example.com/escape-room-2.jpg",
            "image_url_poster": "http://example.com/escape-room-2-poster.jpg"
        }
        """.data(using: .utf8)!
        
        // Decode JSON into EscapeRoom model
        do {
            let escapeRoom = try JSONDecoder().decode(EscapeRoom.self, from: jsonData)
            XCTAssertEqual(escapeRoom.id, "2")
            XCTAssertEqual(escapeRoom.scheduledFilmId, "SF456")
            XCTAssertEqual(escapeRoom.slug, "escape-room-2")
            XCTAssertEqual(escapeRoom.title, "Escape Room 2")
            XCTAssertEqual(escapeRoom.rating, "R")
            XCTAssertEqual(escapeRoom.runTime, "110 min")
            XCTAssertEqual(escapeRoom.synopsis, "Another thrilling escape room experience.")
            XCTAssertEqual(escapeRoom.imageUrl, "http://example.com/escape-room-2.jpg")
            XCTAssertEqual(escapeRoom.imageUrlPoster, "http://example.com/escape-room-2-poster.jpg")
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }
}
