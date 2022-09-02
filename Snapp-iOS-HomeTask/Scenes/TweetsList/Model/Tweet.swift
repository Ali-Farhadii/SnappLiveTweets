//
//  Tweet.swift
//  Snapp-iOS-HomeTask
//
//  Created by Ali Farhadi on 6/9/1401 AP.
//

import Foundation

struct Tweet: Codable {
    let data: TweetData
    let includes: UsersData
    
    enum CodingKeys: String, CodingKey {
        case data, includes
    }
}

struct TweetData: Codable {
    let author_id: String
    let created_at: String
    let id: String
    let text: String
}

struct UsersData: Codable {
    var users: [User]
}

struct User: Codable {
    var name: String
    var username: String
}
