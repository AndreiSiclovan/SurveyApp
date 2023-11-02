//
//  QAService.swift
//  SurveyApp
//
//  Created by Andrei Siclovan on 01.11.2023.
//

import Foundation
import Alamofire

typealias Result<Value> = Swift.Result<Value, AFError>

protocol QAServiceProtocol {
    func getQuestions(completion: @escaping (Result<[Question]>) -> Void)
    func postAnswer(answer: Answer, completion: @escaping (Result<Void>) -> Void)
}

final class QAService: QAServiceProtocol {
    
    private let baseURL = "https://xm-assignment.web.app/"
    
    
    init() {}
    
    func getQuestions(completion: @escaping (Result<[Question]>) -> Void) {
        let path = "questions"
        let url = URL(string: baseURL)!.appendingPathComponent(path)
        
        AF.request(url, method: .get).responseDecodable(of: [Question].self, completionHandler: { response in
            completion(response.result)
        })
    }
    
    func postAnswer(answer: Answer, completion: @escaping (Result<Void>) -> Void) {
        let path = "question/submit"
        let url = URL(string: baseURL)!.appendingPathComponent(path)
        let params: [String: Any] = [
            "id": answer.id,
            "answer": answer.answer
        ]
        
        AF.request(url, method: .post, parameters: params).validate().response(completionHandler: {
            response in
            switch response.result {
            case .success(_):
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
