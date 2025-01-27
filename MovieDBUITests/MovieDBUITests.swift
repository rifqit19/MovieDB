//
//  MovieDBUITests.swift
//  MovieDBUITests
//
//  Created by rifqi triginandri on 25/01/25.
//

import XCTest

final class MovieDBUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {}

    @MainActor
    func testEndlessScrolling() throws {
        let app = XCUIApplication()
        app.launch()

        let movieList = app.scrollViews["movieList"]
        XCTAssertTrue(movieList.exists, "Movie list should exist.")

        movieList.swipeUp()
        movieList.swipeUp()

        let allMovies = movieList.images.allElementsBoundByIndex
        XCTAssertFalse(allMovies.isEmpty, "Movie list should not be empty after scrolling.")

        let lastMovie = allMovies.last
        XCTAssertNotNil(lastMovie, "There should be a last movie element.")
        XCTAssertTrue(lastMovie!.exists, "The last movie should be visible.")
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
