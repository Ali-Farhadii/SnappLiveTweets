//
//  RequestProtocolTests.swift
//  Snapp-iOS-HomeTaskTests
//
//  Created by Ali Farhadi on 6/11/1401 AP.
//

import XCTest
@testable import Snapp_iOS_HomeTask

class RequestProtocolTests: XCTestCase {

    var sut: TweetsListRequests?
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_asURLRequest_givenRequestType_shouldGetURLRequest() throws {
        sut = .addRule(rule: AddRule(add: [.init(value: "Test", tag: "Tag test")]))
        
        let urlRequest = try sut!.asURLRequest()
        
        XCTAssertEqual(urlRequest.method?.rawValue, HTTPMethod.post.rawValue)
    }
    
}
