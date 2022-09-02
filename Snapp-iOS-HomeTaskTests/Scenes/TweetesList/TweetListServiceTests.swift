//
//  TweetListServiceTests.swift
//  Snapp-iOS-HomeTaskTests
//
//  Created by Ali Farhadi on 6/11/1401 AP.
//

import XCTest
@testable import Snapp_iOS_HomeTask

class TweetListServiceTests: XCTestCase {

    var sut: TweetsListService?
    var mockRule: Data?
    
    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: type(of: self))
        if let path = bundle.path(forResource: "MockRule", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path),
                                    options: .mappedIfSafe)
                self.mockRule = data
            }
            catch {}
        }
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_getRule_shouldGetRuleObject() throws {
        let mockURLSession = MockURLSession()
        mockURLSession.data = mockRule
        let mockResponseValidator = MockResponseValidator()
        let mockNetworkManager = MockNetworkManager(urlSession: mockURLSession,
                                                    responseValidator: mockResponseValidator)
        sut = .init(networkManager: mockNetworkManager)
        let expectation = XCTestExpectation(description: "Expect wait for get rule")
        var rule: Rule?
        
        sut?.getRule(completion: { (result: Result<Rule, RequestError>) in
            defer {
                expectation.fulfill()
            }
            switch result {
            case .success(let ruleData):
                rule = ruleData
            case .failure:
                XCTFail()
            }
        })
        
        wait(for: [expectation], timeout: 15)
        let unwrappedRule = try XCTUnwrap(rule?.data?.first)
        XCTAssertEqual(unwrappedRule.value, "Test")
    }
    
}
