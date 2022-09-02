//
//  RequestProtocol.swift
//  Snapp-iOS-HomeTask
//
//  Created by Ali Farhadi on 6/10/1401 AP.
//

import Foundation
import Alamofire

typealias Headers = [String: String]
typealias QueryParameters = [String: String]

protocol RequestProtocol: URLRequestConvertible {
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: Headers? { get }
    var queryParameters: QueryParameters? { get }
    
    func getBody() -> Data?
}

extension RequestProtocol {
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: getURL()!)
        
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = getBody()
        
        return request
    }
    
    private func getURL() -> URL? {
        var urlComponent = URLComponents(string: baseUrl)
        urlComponent?.path += path
        urlComponent?.queryItems = getQueryItems()
        return urlComponent?.url
    }
    
    private func getQueryItems() -> [URLQueryItem]? {
        guard let parameters = queryParameters, !parameters.isEmpty else { return nil }
        
        var queryItems = [URLQueryItem]()
        queryItems = parameters.map { URLQueryItem(name: $0.key,
                                                   value: String(describing: $0.value)) }
        return queryItems
    }
    
}

extension RequestProtocol {
    var baseUrl: String {
        Constants.baseURL
    }
    
    var headers: Headers? {
        ["Authorization": Constants.token,
         "Content-Type": "application/json"]
    }
}
