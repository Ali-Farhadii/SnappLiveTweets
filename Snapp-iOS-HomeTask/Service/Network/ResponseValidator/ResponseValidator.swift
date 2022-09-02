//
//  ResponseValidator.swift
//  Snapp-iOS-HomeTask
//
//  Created by Ali Farhadi on 6/10/1401 AP.
//

import Foundation

struct ResponseValidator: ResponseValidatorProtocol {
    func validation<T: Codable>(response: HTTPURLResponse?, data: Data?) -> Result<T, RequestError> {
        guard let response = response, let data = data else {
            return .failure(.invalidResponse)
        }
        switch response.statusCode {
        case 200...209:
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let model = try decoder.decode(T.self, from: data)
                return .success(model)
            } catch {
                return .failure(.jsonParseError)
            }
        case 400,401:
            return .failure(.authorizationError)
        case 402...499:
            return .failure(.connectionError)
        case 500...599:
            return .failure(.serverUnavailable)
        default:
            return .failure(.unknownError)
        }
    }
}
