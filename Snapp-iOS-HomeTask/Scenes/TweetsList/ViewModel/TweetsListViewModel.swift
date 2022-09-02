//
//  TweetsListViewModel.swift
//  Snapp-iOS-HomeTask
//
//  Created by Ali Farhadi on 6/9/1401 AP.
//

import Foundation
import Combine

class TweetsListViewModel {
    
    let service: TweetsListServiceProtocol
    
    init(service: TweetsListServiceProtocol) {
        self.service = service
    }
    
    @Published var tweets = [Tweet]()
    @Published var isLoading = false
    @Published var errorMessage = ""
    
    func getTweets(with searchValue: String) {
        isLoading = true
        tweets.removeAll()
        
        service.getRule { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let rule):
                self.deleteRule(rule: rule.data?.first?.value,
                                newRule: searchValue)
            case .failure(let error):
                self.errorMessage = error.errorMessage
            }
        }
    }
    
    private func deleteRule(rule: String?, newRule: String) {
        guard let rule = rule else {
            addRule(newRule: newRule)
            return
        }
        
        service.deleteRule(value: rule) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.addRule(newRule: newRule)
            case .failure(let error):
                self.errorMessage = error.errorMessage
            }
        }
    }
    
    private func addRule(newRule: String) {
        self.service.addRule(value: newRule) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.streamTweets()
            case .failure(let error):
                self.errorMessage = error.errorMessage
            }
        }
    }
    
    private func streamTweets() {
        self.service.streamTweets { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let tweet):
                self.tweets.insert(tweet, at: 0)
            case .failure(let error):
                self.errorMessage = error.errorMessage
            }
        }
    }
    
}
