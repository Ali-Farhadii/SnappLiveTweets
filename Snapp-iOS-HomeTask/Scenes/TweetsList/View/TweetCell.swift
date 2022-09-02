//
//  TweetCell.swift
//  Snapp-iOS-HomeTask
//
//  Created by Ali Farhadi on 6/9/1401 AP.
//

import UIKit

class TweetCell: UITableViewCell {
    
    static let reuseIdentifier = "TweetCell"
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .heavy)
        label.textColor = .label
        return label
    }()
    
    private lazy var tweetTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 4
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .secondaryLabel
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TweetCell: TableViewCell {
    func addViews() {
        addSubview(usernameLabel)
        addSubview(tweetTextLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            tweetTextLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10),
            tweetTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            tweetTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            tweetTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    func configCell(with item: Tweet) {
        usernameLabel.text = item.includes.users.first?.username
        tweetTextLabel.text = item.data.text
    }
}
