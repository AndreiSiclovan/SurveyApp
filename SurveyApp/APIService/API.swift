//
//  API.swift
//  SurveyApp
//
//  Created by Andrei Siclovan on 01.11.2023.
//

import Foundation

enum APIError: Error {
    case internalError
    case serverError
    case parsingError
}

enum Method: String {
    case GET
    case POST
}

final class API {
    
    static let shared = API()
//    private let key = "9773994f2cf08f202da08e6a9281eb41"
    
    
    //MARK: - Generic API Call
    
    private let baseURL = "https://xm-assignment.web.app/"
    
    
    func request<T: Codable>(url: String, method: Method, completion: @escaping((Result<T, APIError>) -> Void)) {
        
        guard let url = URL(string: url) else {
            completion(.failure(.internalError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "\(method)"
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        
        call(with: request, completion: completion)
    }
    
    private func call<T: Codable>(with request: URLRequest, completion: @escaping((Result<T, APIError>) -> Void)) {
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                completion(.failure(.serverError))
                return
            }
            
            do {
                guard let data = data else {
                    completion(.failure(.serverError))
                    return
                }
                
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(Result.success(object))
                
            } catch {
                completion(.failure(.parsingError))
            }
        }
        dataTask.resume()
    }
}

