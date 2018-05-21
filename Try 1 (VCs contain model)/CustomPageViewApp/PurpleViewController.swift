//
//  PurpleViewController.swift
//  CustomPageViewApp
//
//  Created by Imanou on 21/05/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//

import UIKit

class PurpleViewController: UIViewController {
    
    var text: String
    var pageIndex: Int
    let label = UILabel()
    
    init(text: String, pageIndex: Int) {
        self.text = text
        self.pageIndex = pageIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .purple
        
        label.text = text
        label.numberOfLines = 0
        label.backgroundColor = .green
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
}
