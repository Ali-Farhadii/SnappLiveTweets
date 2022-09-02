//
//  NetworkManager.swift
//  Snapp-iOS-HomeTask
//
//  Created by Ali Farhadi on 6/10/1401 AP.
//

import Foundation
import Alamofire

class NetworkManager: NetworkManagerProtocol {
    
    let streamSession: Session
    var urlSession: URLSession
    var responseValidator: ResponseValidatorProtocol
    
    init(urlSession: URLSession, streamSession: Session,
         responseValidator: ResponseValidatorProtocol) {
        self.urlSession = urlSession
        self.streamSession = streamSession
        self.responseValidator = responseValidator
    }
    
    init() {
        urlSession = .shared
        streamSession = .default
        responseValidator = ResponseValidator()
    }
    
    static let shared = NetworkManager()
    
    func callEndpoint<T: Codable>(request: RequestProtocol,
                                  completion: @escaping (Result<T, RequestError>) -> Void) {
        
        guard let urlRequest = try? request.asURLRequest() else {
            return completion(.failure(.invalidRequest))
        }
        
        urlSession.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                return completion(.failure(.connectionError))
            }
            
            guard let response = response as? HTTPURLResponse else {
                return completion(.failure(.invalidResponse))
            }
            
            let validationResult: (Result<T, RequestError>) = self.responseValidator.validation(response: response,
                                                                                                data: data)
            return completion(validationResult)
        }
        .resume()
    }
    
    func streamEndpoint<T: Codable>(request: RequestProtocol,
                                    completion: @escaping (Result<T, RequestError>) -> Void) {
        streamSession
            .streamRequest(request)
            .responseStreamDecodable(of: T.self) { stream in
                switch stream.event {
                case let .stream(result):
                    switch result {
                    case .success(let tweet):
                        completion(.success(tweet))
                    default:
                        return
                    }

                case let .complete(completion):
                    print(completion)
                }
            }
    }
    
}
