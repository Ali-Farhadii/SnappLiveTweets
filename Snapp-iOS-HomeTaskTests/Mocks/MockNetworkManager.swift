//
//  MockNetworkManager.swift
//  Snapp-iOS-HomeTaskTests
//
//  Created by Ali Farhadi on 6/11/1401 AP.
//

import Foundation
@testable import Snapp_iOS_HomeTask

class MockNetworkManager: NetworkManagerProtocol {
    
    var urlSession: URLSession
    var responseValidator: ResponseValidatorProtocol
    
    init(urlSession: URLSession,
         responseValidator: ResponseValidatorProtocol) {
        self.urlSession = urlSession
        self.responseValidator = responseValidator
    }
    
    func callEndpoint<T: Codable>(request: RequestProtocol,
                                  completion: @escaping (Result<T, RequestError>) -> Void) {
        let request = try! TweetsListRequests.getRule.asURLRequest()
        urlSession.dataTask(with: request) { data, response, error in
            let validatedResult: (Result<T, RequestError>) = self.responseValidator
                .validation(response: response as? HTTPURLResponse, data: data)
            return completion(validatedResult)
        }
        .resume()
    }
    
    func streamEndpoint<T: Codable>(request: RequestProtocol,
                                    completion: @escaping (Result<T, RequestError>) -> Void) {}
}
