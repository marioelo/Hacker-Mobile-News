//
//  StoryViewCell.swift
//  Hacker Mobile News
//
//  Created by Mario Elorza on 08-05-21.
//

import UIKit

class StoryViewCell: UITableViewCell {
    
    static let reuseID  = "StoryViewCell"
    
    let titleLabel: TitleLabel = {
        let label = TitleLabel(fontSize: 18)
        label.numberOfLines = 2
        return label
    }()
    
    let authorLabel = SecondaryLabel(fontSize: 16)
    let timingLabel = SecondaryLabel(fontSize: 16)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(story: Story) {
        titleLabel.text = story.title
        authorLabel.text = "\(story.author) - "
        timingLabel.text = story.createdAt.timeAgoString()
    }
    
    func configure() {
        accessoryType = .disclosureIndicator
        let secondaryLabelsStack = UIStackView(arrangedSubviews: [
            authorLabel,
            timingLabel
        ])
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            secondaryLabelsStack
        ])
        stackView.axis = .vertical
        stackView.spacing = 4
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40)
        ])
    }

}
