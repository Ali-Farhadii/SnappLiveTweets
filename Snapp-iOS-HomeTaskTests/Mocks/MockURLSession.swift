//
//  MockURLSession.swift
//  Snapp-iOS-HomeTaskTests
//
//  Created by Ali Farhadi on 6/11/1401 AP.
//

import Foundation

typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

class MockURLSession: URLSession {
    
    var data: Data?
    var error: Error?
  
    override func dataTask(with request: URLRequest,
                           completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        
        return MockURLSessionDataTask {
            completionHandler(data, nil, error)
        }
    }
}
