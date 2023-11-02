//
//  QuestionsViewModel.swift
//  SurveyApp
//
//  Created by Andrei Siclovan on 01.11.2023.
//

import Foundation

final class QuestionsViewModel: ObservableObject {
    
    //MARK: Selections
    
    @Published var questions: [Question] = []
    @Published var page: Int = 0 {
        didSet {
            answer = currentQuestion.answer?.answer ?? ""
        }
    }
    @Published var totalQuestions: Int = 0
    @Published var totalSubmitedAnswers: Int = 0
    @Published var answer: String = ""
    @Published var showBanner: Bool = false
    @Published var bannerType: BannerType = .success
    
    private var currentQuestion: Question {
        guard questions.count > page else {
            return .init(id: 0, question: "")
        }
        return questions[page]
    }
    
    //MARK: Dependencies
    
    let qaService: QAServiceProtocol
    
    //MARK: Life Cycle
    
    init(qaService: QAServiceProtocol = QAService()) {
        self.qaService = qaService
    }
    
    func getQuestion() -> String {
        guard !questions.isEmpty else {
            return ""
        }
        
        return currentQuestion.question
    }
    
    func submitAnswer(answer: String) {
        let id = currentQuestion.id
        let answer: Answer = .init(id: id, answer: answer)
        postAnswer(answer: answer)
    }
    
    func hasAnswer() -> Bool {
        guard !questions.isEmpty else {
            return false
        }
        
        return currentQuestion.answer != nil
    }
    
    //MARK: Service calls
    
    func getQuestions() {
        qaService.getQuestions() { [weak self] result in
            switch result {
            case .failure(_):
                self?.showBanner(type: .error)
            case .success(let questions):
                self?.questions = questions
                self?.totalQuestions = questions.count
            }
        }
    }
    
    private func postAnswer(answer: Answer) {
        qaService.postAnswer(answer: answer) { [weak self] result in
            guard let self else {
                return
            }
            switch result {
            case .failure(_):
                showBanner(type: .error)
            case .success():
                self.showBanner(type: .success)
                self.questions[self.page].answer = answer
                self.totalSubmitedAnswers += 1
            }
        }
    }
    
    //MARK: Banner
    
    private func showBanner(type: BannerType) {
        self.bannerType = type
        self.showBanner = true
    }
}
