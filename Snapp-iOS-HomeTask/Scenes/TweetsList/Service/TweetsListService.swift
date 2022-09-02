//
//  TweetsListService.swift
//  Snapp-iOS-HomeTask
//
//  Created by Ali Farhadi on 6/9/1401 AP.
//

import Foundation

class TweetsListService: TweetsListServiceProtocol {
    
    var networkManager: NetworkManagerProtocol
    
    // We can also inject networkManager for testing purposes.
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    init() {
        networkManager = NetworkManager.shared
    }
    
    public static let shared: TweetsListService = TweetsListService()
    
    func getRule(completion: @escaping ((Result<Rule, RequestError>) -> Void)) {
        networkManager
            .callEndpoint(request: TweetsListRequests.getRule) { (result: Result<Rule, RequestError>) in
                completion(result)
            }
    }
    
    func deleteRule(value: String, completion: @escaping ((Result<DeleteRuleResponse, RequestError>) -> Void)) {
        let deleteRule = DeleteRule(delete: .init(values: [value]))
        networkManager
            .callEndpoint(request: TweetsListRequests.deleteRule(rule: deleteRule)) { (result: Result<DeleteRuleResponse,
                                                                                       RequestError>) in
                completion(result)
            }
    }
    
    func addRule(value: String, completion: @escaping ((Result<Rule, RequestError>) -> Void)) {
        let addRule = AddRule(add: [.init(value: value, tag: "Rule tag")])
        networkManager
            .callEndpoint(request: TweetsListRequests.addRule(rule: addRule)) { (result: Result<Rule,
                                                                                 RequestError>) in
                completion(result)
            }
    }
    
    func streamTweets(completion: @escaping ((Result<Tweet, RequestError>) -> Void)) {
        networkManager
            .streamEndpoint(request: TweetsListRequests.streamTweets) { (result: Result<Tweet, RequestError>) in
                completion(result)
            }
    }
    
}
