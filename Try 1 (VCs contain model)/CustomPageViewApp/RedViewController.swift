//
//  RedViewController.swift
//  CustomPageViewApp
//
//  Created by Imanou on 21/05/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//

import UIKit

class RedViewController: UIViewController {
    
    var onDismiss: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        let buttonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(performDosmiss))
        navigationItem.leftBarButtonItem = buttonItem
    }
    
    @objc func performDosmiss(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: { self.onDismiss?() })
    }
    
}
