//
//  TweetsListViewController.swift
//  Snapp-iOS-HomeTask
//
//  Created by Ali Farhadi on 6/9/1401 AP.
//

import UIKit
import Combine

class TweetsListViewController: UIViewController {

    var viewModel: TweetsListViewModel
    var coordinator: AppCoordinator
    private var cancellable = Set<AnyCancellable>()
    
    init(viewModel: TweetsListViewModel, coordinator: AppCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tweetsList: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TweetCell.self, forCellReuseIdentifier: TweetCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search tweet"
        return searchController
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.style = .large
        return indicator
    }()
    
    private lazy var hintLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Search with search bar above to see tweets"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .secondaryLabel
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupConstraints()
        configViewController()
        setupBinding()
    }

}

extension TweetsListViewController: ViewController {
    func addViews() {
        view.addSubview(tweetsList)
        view.addSubview(loadingIndicator)
        view.addSubview(hintLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tweetsList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tweetsList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tweetsList.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tweetsList.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            hintLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hintLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    func configViewController() {
        view.backgroundColor = .systemBackground
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setupBinding() {
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self = self else { return }
                isLoading ? self.loadingIndicator.startAnimating() :
                            self.loadingIndicator.stopAnimating()
                self.hintLabel.isHidden = isLoading || !self.viewModel.tweets.isEmpty
            }
            .store(in: &cancellable)
        
        viewModel.$tweets
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newTweets in
                guard let self = self else { return }
                self.tweetsList.reloadData()
            }
            .store(in: &cancellable)
        
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                guard let self = self, !errorMessage.isEmpty else { return }
                self.showAlert(title: "Connection failed",
                               message: errorMessage)
            }
            .store(in: &cancellable)
        
        let publisher = NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification,
                                                             object: searchController.searchBar.searchTextField)
            .compactMap { ($0.object as? UISearchTextField)?.text }
        
        publisher
            .debounce(for: .milliseconds(700), scheduler: DispatchQueue.main)
            .sink { [weak self] searchedText in
                guard let self = self, !searchedText.isEmpty else { return }
                self.viewModel.getTweets(with: searchedText)
            }
            .store(in: &cancellable)
    }
}

extension TweetsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetCell.reuseIdentifier) as! TweetCell
        cell.configCell(with: viewModel.tweets[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        coordinator.pushToTweetDetail(with: viewModel.tweets[indexPath.row])
    }
}
