//
//  QuestionsViewTests.swift
//  SurveyAppUITests
//
//  Created by Andrei Siclovan on 02.11.2023.
//

import XCTest

final class QuestionsViewTests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launch()
        app.buttons["startSurvey"].tap()
    }

    func testSubmitButton() {
        let submitButton = app.buttons["submitButton"]
        XCTAssertTrue(submitButton.waitForExistence(timeout: 2))
        XCTAssertFalse(submitButton.isEnabled)
        
        let answer = app.textFields["answerTextField"]
        XCTAssertTrue(answer.waitForExistence(timeout: 2))
        answer.tap()
        answer.typeText("Black")
        
        XCTAssertTrue(submitButton.isEnabled)
    }
    
    func testTextField() {
        let defaultText = "Type your answer here"
        let answer = app.textFields["answerTextField"]
        XCTAssertTrue(answer.waitForExistence(timeout: 2))
        answer.tap()
        answer.typeText("Black")
        
        app.buttons["submitButton"].tap()
        
        XCTAssertEqual(answer.value as! String, "Black")
        
        app.buttons["nextButton"].tap()
        
        XCTAssertEqual(answer.value as! String, defaultText)
    }
}
