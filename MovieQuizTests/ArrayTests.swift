//
//  ArrayTests.swift
//  MovieQuiz
//
//  Created by Воробьева Юлия on 12.09.2025.
//

import UIKit

@testable import MovieQuiz
import XCTest

class ArrayTests: XCTestCase {
    func testGetValueInRange() throws {
        // Given
        let array = [1, 1, 2, 3, 5]

        // When
        let value = array[safe: 2]

        // Then
        XCTAssertNotNil(value)
        XCTAssertEqual(value, 2)
    }

    func testGetValueOutOfRange() throws {
        // Given
        let array = [1, 1, 2, 3, 5]

        // When
        let value = array[safe: 20]

        // Then
        XCTAssertNil(value)
    }
}
