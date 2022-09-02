//
//  RequestError.swift
//  Snapp-iOS-HomeTask
//
//  Created by Ali Farhadi on 6/10/1401 AP.
//

import Foundation

enum RequestError: Error {
    case connectionError
    case invalidRequest
    case jsonParseError
    case invalidResponse
    case authorizationError
    case serverUnavailable
    case unknownError
}

extension RequestError {
    public var errorMessage: String {
        switch self {
        case .connectionError:
            return "Connection error"
        case .invalidRequest:
            return "The request is invalid"
        case .jsonParseError:
            return "JSON parsing failed, make sure response has a valid JSON"
        case .invalidResponse:
            return "Response is invalid"
        case .authorizationError:
            return ""
        case .serverUnavailable:
            return "Server is down"
        default:
            return "Network Error with` \(self)` thrown"
        }
    }
}
