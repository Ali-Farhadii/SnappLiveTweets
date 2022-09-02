//
//  AppCoordinator.swift
//  Snapp-iOS-HomeTask
//
//  Created by Ali Farhadi on 6/9/1401 AP.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.navigationBar.prefersLargeTitles = true
    }
    
    func start() {
        let tweetListService = TweetsListService(networkManager: NetworkManager.shared)
        let tweetsListViewModel = TweetsListViewModel(service: tweetListService)
        let tweetsListVC = TweetsListViewController(viewModel: tweetsListViewModel, coordinator: self)
        tweetsListVC.title = "Tweets"
        navigationController.pushViewController(tweetsListVC, animated: true)
    }
    
    func pushToTweetDetail(with tweet: Tweet) {
        let tweetDetailViewModel = TweetDetailViewModel(tweet: tweet)
        let tweetDetailVC = TweetDetailViewController(viewModel: tweetDetailViewModel)
        tweetDetailVC.title = "Tweet Detail"
        navigationController.pushViewController(tweetDetailVC, animated: true)
    }
}
