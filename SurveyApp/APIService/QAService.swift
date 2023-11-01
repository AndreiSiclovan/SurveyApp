//
//  QAService.swift
//  SurveyApp
//
//  Created by Andrei Siclovan on 01.11.2023.
//

import Foundation
import Alamofire

typealias Result<Value> = Swift.Result<Value, APIError>
final class QAService {
    
    private let baseURL = "https://xm-assignment.web.app/"
    
    
    init() {}
    
    func getQuestions(completion: @escaping (Result<[Question]>) -> Void) {
        let path = "questions"
        let url = URL(string: baseURL)!.appendingPathComponent(path)
        API.request(.get, url: url).responseDecodable(of: [Question].self, completionHandler: { response in
            completion(JSONParser.decodeJson(response))
        })
    }
    
    func postAnswer(answer: Answer, completion: @escaping (Result<Void>) -> Void) {
        let path = "question/submit"
        let url = URL(string: baseURL)!.appendingPathComponent(path)
        let params: [String: Any] = [
            "id": answer.id,
            "answer": answer.answer
        ]
        
        print("Answer, params", params)
        
        API.request(.post, url: url, parameters: params).responseData(completionHandler: { response in
            
            if response.response?.statusCode == 200 {
                completion(.success(()))
            } else {
                completion(.failure(.serverError))
            }
        })
    }
}


class JSONParser {
    static func decodeJson<T: Codable>(_ response: DataResponse<T, AFError>) -> Result<T> {
        guard let jsonData = response.data else {
            return .failure(.serverError)
        }
        
        do {
            let object = try JSONDecoder().decode(T.self, from: jsonData)
            return .success(object)
        } catch {
            return .failure(.parsingError)
        }
    }
}
