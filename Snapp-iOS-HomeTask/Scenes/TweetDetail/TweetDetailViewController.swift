//
//  TweetDetailViewController.swift
//  Snapp-iOS-HomeTask
//
//  Created by Ali Farhadi on 6/9/1401 AP.
//

import UIKit

class TweetDetailViewController: UIViewController {

    var viewModel: TweetDetailViewModel
    
    init(viewModel: TweetDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 15
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .heavy)
        label.textColor = .label
        return label
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .black)
        label.textColor = .label
        return label
    }()
    
    private lazy var tweetTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupConstraints()
        configViewController()
        setupBinding()
    }

}

extension TweetDetailViewController: ViewController {
    func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(usernameLabel)
        stackView.addArrangedSubview(tweetTextLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15),
            
            tweetTextLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            tweetTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            tweetTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
        ])
        stackView.setCustomSpacing(20, after: usernameLabel)
    }
    
    func configViewController() {
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func setupBinding() {
        nameLabel.text = viewModel.name
        usernameLabel.text = viewModel.username
        tweetTextLabel.text = viewModel.tweetText
    }
}
