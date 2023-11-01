//
//  API.swift
//  SurveyApp
//
//  Created by Andrei Siclovan on 01.11.2023.
//

import Foundation
import Alamofire

enum APIError: Error {
    case serverError
    case parsingError
}

//enum Method: String {
//    case GET
//    case POST
//}

//final class API {
    
//    static let shared = API()
//    private let key = "9773994f2cf08f202da08e6a9281eb41"
    
    
    //MARK: - Generic API Call
    
//    func getRequest<T: Codable>(url: String, completion: @escaping((Result<T, APIError>) -> Void)) {
//        guard let url = URL(string: url) else {
//            completion(.failure(.internalError))
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
//
//        call(with: request, completion: completion)
//    }
//
//    func postRequest(url: String, params: [String: Any], completion: @escaping((Result<(), APIError>) -> Void)) {
//        guard let url = URL(string: url) else {
//            completion(.failure(.internalError))
//            return
//        }
//        print("PARAMS", params)
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
////        request.setValue("application/json", forHTTPHeaderField: "Accept")
//
//        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
//        request.httpBody = jsonData
//
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let error {
//                print("ERROR POSTING", error)
//                completion(.failure(.serverError))
//                return
//            }
//            guard let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200 else {
//                completion(.failure(.serverError))
//                return
//            }
//
//            print("HTTP status code", httpStatus.statusCode)
//            completion(.success)
//        }
//
//        task.resume()
//    }
//
//    private func call<T: Codable>(with request: URLRequest, completion: @escaping((Result<T, APIError>) -> Void)) {
//
//        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//            guard error == nil else {
//                completion(.failure(.serverError))
//                return
//            }
//
//            do {
//                guard let data = data else {
//                    completion(.failure(.serverError))
//                    return
//                }
//
//                let object = try JSONDecoder().decode(T.self, from: data)
//                completion(.success(object))
//
//            } catch {
//                completion(.failure(.parsingError))
//            }
//        }
//        dataTask.resume()
//    }
//}
//
//public extension Result where Success == Void {
//
//    /// A success, storing a Success value.
//    ///
//    /// Instead of `.success(())`, now  `.success`
//    static var success: Result {
//        return .success(())
//    }
//}

class API {
    
    class func request(_ method: HTTPMethod, url: URL, parameters: [String : Any]? = nil) -> DataRequest {
        
        // append http headers
//        var mutableHeaders = headers?.compactMap { HTTPHeader(name: $0.key, value: $0.value) } ?? []
//        APISettings().httpHeaders.forEach { mutableHeaders.append($0) }
//        "Content-Type": "application/json"
//        let header: HTTPHeader = .init(name: "Content-Type", value: "application/json")
        
//        var request = try! URLRequest(url: url, method: method, headers: HTTPHeaders(header))
//        var request = try! URLRequest(url: url, method: method)
//        request = try! encoding.default.encode(request, with: parameters)
//        request = try! JSONEncoder().en
        
//        request.timeoutInterval = 30.0;//seconds
        return AF.request(url, method: method, parameters: parameters)
    }
}
