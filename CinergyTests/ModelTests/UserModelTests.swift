//
//  UserModelTests.swift
//  CinergyTests
//
//  Created by Jinu on 28/08/2024.
//

import XCTest
@testable import Cinergy

class UserModelTests: XCTestCase {

    func testUserDecoding() {
        // Sample JSON data
        let jsonData = """
        {
            "response": "Success",
            "token": "abc123",
            "printerName": "Office Printer",
            "foodMenu": 1,
            "attractionsMenu": 2,
            "id": 12345,
            "location": "New York"
        }
        """.data(using: .utf8)!
        
        // Decode JSON into User model
        do {
            let user = try JSONDecoder().decode(User.self, from: jsonData)
            XCTAssertEqual(user.response, "Success")
            XCTAssertEqual(user.token, "abc123")
            XCTAssertEqual(user.printerName, "Office Printer")
            XCTAssertEqual(user.foodMenu, 1)
            XCTAssertEqual(user.attractionsMenu, 2)
            XCTAssertEqual(user.id, 12345)
            XCTAssertEqual(user.location, "New York")
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }

    func testUserEncoding() {
        // Create a User instance
        let user = User(
            response: "Success",
            token: "abc123",
            printerName: "Office Printer",
            foodMenu: 1,
            attractionsMenu: 2,
            id: 12345,
            location: "New York"
        )
        
        // Encode User model into JSON
        do {
            let jsonData = try JSONEncoder().encode(user)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            XCTAssertTrue(jsonString.contains("\"response\":\"Success\""))
            XCTAssertTrue(jsonString.contains("\"token\":\"abc123\""))
            XCTAssertTrue(jsonString.contains("\"printerName\":\"Office Printer\""))
            XCTAssertTrue(jsonString.contains("\"foodMenu\":1"))
            XCTAssertTrue(jsonString.contains("\"attractionsMenu\":2"))
            XCTAssertTrue(jsonString.contains("\"id\":12345"))
            XCTAssertTrue(jsonString.contains("\"location\":\"New York\""))
        } catch {
            XCTFail("Encoding failed: \(error)")
        }
    }

    func testOptionalValuesHandling() {
        // Sample JSON data with some missing optional values
        let jsonData = """
        {
            "response": "Success",
            "id": 12345
        }
        """.data(using: .utf8)!
        
        // Decode JSON into User model
        do {
            let user = try JSONDecoder().decode(User.self, from: jsonData)
            XCTAssertEqual(user.response, "Success")
            XCTAssertNil(user.token)
            XCTAssertNil(user.printerName)
            XCTAssertNil(user.foodMenu)
            XCTAssertNil(user.attractionsMenu)
            XCTAssertEqual(user.id, 12345)
            XCTAssertNil(user.location)
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }
}
