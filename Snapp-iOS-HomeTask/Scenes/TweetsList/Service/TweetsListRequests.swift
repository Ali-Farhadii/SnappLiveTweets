//
//  TweetsListRequests.swift
//  Snapp-iOS-HomeTask
//
//  Created by Ali Farhadi on 6/10/1401 AP.
//

import Foundation

enum TweetsListRequests: RequestProtocol {
    
    case getRule
    case deleteRule(rule: DeleteRule)
    case addRule(rule: AddRule)
    case streamTweets
    
    var path: String {
        switch self {
        case .streamTweets:
            return "2/tweets/search/stream"
        default:
            return "2/tweets/search/stream/rules"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getRule, .streamTweets:
            return .get
        case .deleteRule, .addRule:
            return .post
        }
    }
    
    var queryParameters: QueryParameters? {
        switch self {
        case .streamTweets:
            return ["tweet.fields": "created_at",
                    "expansions": "author_id",
                    "user.fields": "created_at"]
            
        default:
            return nil
        }
    }
    
    func getBody() -> Data? {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        switch self {
        case .deleteRule(let rule):
            return try? encoder.encode(rule)
        case .addRule(let rule):
            return try? encoder.encode(rule)
        default:
            return nil
        }
    }
}
