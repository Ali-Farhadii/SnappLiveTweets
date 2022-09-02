//
//  MockResponseValidator.swift
//  Snapp-iOS-HomeTaskTests
//
//  Created by Ali Farhadi on 6/11/1401 AP.
//

import Foundation
@testable import Snapp_iOS_HomeTask

struct MockResponseValidator: ResponseValidatorProtocol {
    func validation<T:Codable>(response: HTTPURLResponse?, data: Data?) -> Result<T, RequestError> {
        guard let data = data else {
            return .failure(RequestError.connectionError)
        }
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let model = try decoder.decode(T.self, from: data)
            return .success(model)
        } catch {
            return .failure(.jsonParseError)
        }
    }
}
