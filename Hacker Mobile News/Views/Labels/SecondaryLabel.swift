//
//  SecondaryLabel.swift
//  Hacker Mobile News
//
//  Created by Mario Elorza on 08-05-21.
//

import UIKit

class SecondaryLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        self.font = .systemFont(ofSize: fontSize)
    }
    
    private func configure() {
        textColor = .secondaryLabel
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
