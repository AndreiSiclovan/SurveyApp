//
//  QuestionsViewModel.swift
//  SurveyApp
//
//  Created by Andrei Siclovan on 01.11.2023.
//

import Foundation

final class QuestionsViewModel: ObservableObject {
    
    @Published var questions: [Question] = []
    @Published var page: Int = 0 {
        didSet {
            answer = questions[page].answer?.answer ?? ""
        }
    }
    @Published var totalQuestions: Int = 0
    @Published var totalSubmitedAnswers: Int = 0
    @Published var answer: String = ""
    @Published var showBanner: Bool = false
    @Published var bannerType: BannerType = .Success
    let questionsService: QAService = .init()
    
    init() {
        
    }
    
    func getQuestions() {
        questionsService.getQuestions() { [weak self] result in
            switch result {
            case .failure(let error):
                print("ERROR", error.localizedDescription)
            case .success(let questions):
                DispatchQueue.main.async {
                    self?.questions = questions
                    self?.totalQuestions = questions.count
                    print("GOT QUESTIONS", questions)
                    
                }
            }
        }
    }
    
    func getQuestion() -> String {
        guard !questions.isEmpty else {
            return ""
        }
        
        return questions[page].question
    }
    
    func submitAnswer(answer: String) {
        let id = questions[page].id
        let answer: Answer = .init(id: id, answer: answer)
        questionsService.postAnswer(answer: answer) { [weak self] result in
            guard let self else {
                return
            }


            switch result {
            case .failure(let error):
                print("ERROR Posting", error.localizedDescription)
                DispatchQueue.main.async {
                    self.bannerType = .Error
                    self.showBanner = true
                }
            case .success():
                print("Success")
                DispatchQueue.main.async {
                    self.questions[self.page].answer = answer
                    self.totalSubmitedAnswers += 1
                    self.bannerType = .Success
                    self.showBanner = true
                }
            }
        }
    }
    
    func hasAnswer() -> Bool {
        guard !questions.isEmpty else {
            return false
        }
        
        return questions[page].answer != nil
    }
}
