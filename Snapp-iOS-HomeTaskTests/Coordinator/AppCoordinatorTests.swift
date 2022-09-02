//
//  AppCoordinatorTests.swift
//  Snapp-iOS-HomeTaskTests
//
//  Created by Ali Farhadi on 6/9/1401 AP.
//

import XCTest
@testable import Snapp_iOS_HomeTask

class AppCoordinatorTest: XCTestCase {

    var sut: AppCoordinator?
    
    override func setUp() {
        super.setUp()
        let navController = UINavigationController()
        sut = AppCoordinator(navigationController: navController)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_start_shouldPresentTweetListVC() {
        guard let sut = sut else {
            XCTFail()
            return
        }
        
        sut.start()
        
        let topVC = sut.navigationController.visibleViewController as? TweetsListViewController
        XCTAssertNotNil(topVC, "The top VC of navController should be TweetsListViewController")
    }
    
    func test_pushToTweetDetail_shouldPresentTweetDetailVC() {
        guard let sut = sut else {
            XCTFail()
            return
        }
        
        sut.pushToTweetDetail(with: Tweet(data: .init(author_id: "",
                                                      created_at: "",
                                                      id: "", text: ""),
                                          includes: .init(users: [.init(name: "",
                                                                        username: "")])))
        
        let topVC = sut.navigationController.visibleViewController as? TweetDetailViewController
        XCTAssertNotNil(topVC, "The top VC of navController should be TweetDetailViewController")
    }
    
}
