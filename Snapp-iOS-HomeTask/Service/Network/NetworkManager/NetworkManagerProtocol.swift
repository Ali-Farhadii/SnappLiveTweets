//
//  NetworkManagerProtocol.swift
//  Snapp-iOS-HomeTask
//
//  Created by Ali Farhadi on 6/10/1401 AP.
//

import Foundation

protocol NetworkManagerProtocol {
    var urlSession: URLSession { get set }
    var responseValidator: ResponseValidatorProtocol { get set }
    
    func callEndpoint<T: Codable>(request: RequestProtocol,
                                  completion: @escaping (Result<T, RequestError>) -> Void)
    func streamEndpoint<T: Codable>(request: RequestProtocol,
                                    completion: @escaping (Result<T, RequestError>) -> Void)
}
