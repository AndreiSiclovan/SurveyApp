//
//  QuestionsViewModelTests.swift
//  SurveyAppTests
//
//  Created by Andrei Siclovan on 02.11.2023.
//

import XCTest
@testable import SurveyApp

final class QuestionsViewModelTests: XCTestCase {
    
    private var qaService: QAServiceMock!
    private var viewModel: QuestionsViewModel!
    
    override func setUpWithError() throws {
        qaService = QAServiceMock()
        viewModel = QuestionsViewModel(qaService: qaService)
    }
    
    override func tearDownWithError() throws {
        qaService = nil
        viewModel = nil
    }
    
    func testGetQuestions() {
        viewModel.getQuestions()
        XCTAssertFalse(viewModel.questions.isEmpty)
        XCTAssertEqual(viewModel.questions.count, 2)
    }
    
    func testSubmitAnswer() {
        viewModel.questions = [.init(id: 1, question: "What is your favorite color?")]
        let answer = "Black"
        viewModel.submitAnswer(answer: answer)
        
        XCTAssertEqual(viewModel.totalSubmitedAnswers, 1)
        
        ///Check if banner is shown
        XCTAssertEqual(viewModel.showBanner, true)
        XCTAssertEqual(viewModel.bannerType, .success)
    }
    
    func testQuestionHasAnswerAfterSubmitted() {
        viewModel.questions = [.init(id: 1, question: "What is your favorite color?")]
        let answer = "Black"
        viewModel.submitAnswer(answer: answer)
        
        XCTAssertTrue(viewModel.hasAnswer())
    }
}
