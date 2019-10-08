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
           let label = UILabel()
        label.text = user.name.first
           return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(nameLabel)
        configureConstraints()
        
        
        self.view.backgroundColor = .yellow
    }
    

    private func configureConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)])
    }


}
