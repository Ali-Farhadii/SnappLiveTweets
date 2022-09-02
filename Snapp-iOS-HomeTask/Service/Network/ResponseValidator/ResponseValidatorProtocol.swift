//
//  ResponseValidatorProtocol.swift
//  Snapp-iOS-HomeTask
//
//  Created by Ali Farhadi on 6/10/1401 AP.
//

import Foundation

protocol ResponseValidatorProtocol {
    func validation<T: Codable>(response: HTTPURLResponse?, data: Data?) -> Result<T, RequestError>
}

