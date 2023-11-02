//
//  QAServiceMock.swift
//  SurveyAppTests
//
//  Created by Andrei Siclovan on 02.11.2023.
//

import Foundation
@testable import SurveyApp

class QAServiceMock: QAServiceProtocol {
    func getQuestions(completion: @escaping (Result<[Question]>) -> Void) {
        let jsonString = "[{\"id\":1,\"question\":\"What is your favorite color?\"},{\"id\":2,\"question\":\"What is your favorite app?\"}]"
        let data = jsonString.data(using: .utf8)!
        
        do {
            let questions = try JSONDecoder().decode([Question].self, from: data)
            completion(.success(questions))
        } catch {
            let error = NSError(domain: "MockNetworkingServiceErrorDomain", code: -1, userInfo: nil)
            completion(.failure(.parameterEncoderFailed(reason: .encoderFailed(error: error))))
        }
    }
    
    func postAnswer(answer: Answer, completion: @escaping (Result<Void>) -> Void) {
        completion(.success(()))
    }
}
