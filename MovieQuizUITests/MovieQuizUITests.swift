//
//  MovieQuizUITests.swift
//  MovieQuizUITests
//
//  Created by Воробьева Юлия on 13.09.2025.
//

import XCTest

final class MovieQuizUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        app = XCUIApplication()
        app.launch()
        
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        app.terminate()
        app = nil
    }
    
    func testYesButton() {
        sleep(7)
        
        let firstPoster = app.images["Poster"]
        let firstPosterData = firstPoster.screenshot().pngRepresentation
        
        app.buttons["Yes"].tap()
        sleep(5)
        
        let secondPoster = app.images["Poster"]
        let secondPosterData = secondPoster.screenshot().pngRepresentation
        
        let indexLabel = app.staticTexts["Index"]
        
        XCTAssertNotEqual(firstPosterData, secondPosterData)
        XCTAssertEqual(indexLabel.label, "2/10")
    }
    
    func testNoButton() {
        sleep(7)
        
        let firstPoster = app.images["Poster"]
        let firstPosterData = firstPoster.screenshot().pngRepresentation
        
        app.buttons["No"].tap()
        sleep(5)
        
        let secondPoster = app.images["Poster"]
        let secondPosterData = secondPoster.screenshot().pngRepresentation
        
        let indexLabel = app.staticTexts["Index"]
        
        XCTAssertNotEqual(firstPosterData, secondPosterData)
        XCTAssertEqual(indexLabel.label, "2/10")
    }
    
    func testShowAlertInEndGame() {
        sleep(7)
        for i in 0..<10 {
            if i % 2 == 0 {
                app.buttons["Yes"].tap()
            } else {
                app.buttons["No"].tap()
            }
            sleep(3)
        }
        
        let alert = app.alerts["EndGameAlert"]
        
        sleep(3)
        XCTAssertTrue(alert.exists)
        XCTAssertEqual(alert.buttons.firstMatch.label, "Сыграть ещё раз")
        XCTAssertEqual(alert.label, "Этот раунд окончен!")
    }
    
    func testAlertDismiss() {
        sleep(7)
        for i in 0..<10 {
            if i % 2 == 0 {
                app.buttons["Yes"].tap()
            } else {
                app.buttons["No"].tap()
            }
            sleep(3)
        }
        
        let alert = app.alerts["EndGameAlert"]
        alert.buttons.firstMatch.tap()
        
        sleep(3)
        
        let indexLabel = app.staticTexts["Index"]
        
        XCTAssertFalse(alert.exists)
        XCTAssertEqual(indexLabel.label, "1/10")
    }
}
