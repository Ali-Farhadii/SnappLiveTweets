//
//  TweetDetailViewModel.swift
//  Snapp-iOS-HomeTask
//
//  Created by Ali Farhadi on 6/9/1401 AP.
//

import Foundation

class TweetDetailViewModel {
    
    var tweetText: String
    var name: String
    var username: String
    
    init(tweet: Tweet) {
        tweetText = tweet.data.text
        name = tweet.includes.users.first?.name ?? ""
        username = "@\(tweet.includes.users.first?.username ?? "")"
    }
    
}
