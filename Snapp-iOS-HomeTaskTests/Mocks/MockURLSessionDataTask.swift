//
//  MockURLSessionDataTask.swift
//  Snapp-iOS-HomeTaskTests
//
//  Created by Ali Farhadi on 6/11/1401 AP.
//

import Foundation

class MockURLSessionDataTask: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
   
    override func resume() {
        closure()
    }
}
