//
//  TweetsListServiceProtocol.swift
//  Snapp-iOS-HomeTask
//
//  Created by Ali Farhadi on 6/9/1401 AP.
//

import Foundation

protocol TweetsListServiceProtocol {
    var networkManager: NetworkManagerProtocol { get set }
    
    func getRule(completion: @escaping ((Result<Rule, RequestError>) -> Void))
    func deleteRule(value: String, completion: @escaping ((Result<DeleteRuleResponse, RequestError>) -> Void))
    func addRule(value: String, completion: @escaping ((Result<Rule, RequestError>) -> Void))
    func streamTweets(completion: @escaping ((Result<Tweet, RequestError>) -> Void))
}
