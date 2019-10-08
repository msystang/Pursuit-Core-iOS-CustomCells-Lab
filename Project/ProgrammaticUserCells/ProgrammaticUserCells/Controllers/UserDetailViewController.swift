//
//  UserDetailViewController.swift
//  ProgrammaticUserCells
//
//  Created by Sunni Tang on 10/8/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    var user: User!
    
    lazy var nameLabel: UILabel! = {
        let label = UILabel(frame: CGRect(x: 100, y: 300, width: 400, height: 400))
        label.text = "\(user.name.title) \(user.name.first) \(user.name.last)"
        return label
    }()
    
    lazy var emailLabel: UILabel! = {
        let label = UILabel(frame: CGRect(x: 100, y: 350, width: 400, height: 400))
        label.text = "\(user.email)"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        
        addSubviews()
        configureConstraints()
    }
    
    private func addSubviews() {
        self.view.addSubview(nameLabel)
        self.view.addSubview(emailLabel)
    }

    private func configureConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            emailLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 20 ),
            emailLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 20)
        ])
    }


}
