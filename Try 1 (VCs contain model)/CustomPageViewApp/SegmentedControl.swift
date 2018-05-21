//
//  SegmentedControl.swift
//  CustomPageViewApp
//
//  Created by Imanou on 21/05/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//

import UIKit

class SegmentedControl: UISegmentedControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        tintColor = .clear

        let nonSelectedAttributes = [
            NSAttributedStringKey.font : UIFont(name: "DINCondensed-Bold", size: 18)!,
            NSAttributedStringKey.foregroundColor: UIColor.lightGray
        ]
        setTitleTextAttributes(nonSelectedAttributes, for: .normal)

        let selectedAttributes = [
            NSAttributedStringKey.font : UIFont(name: "DINCondensed-Bold", size: 18)!,
            NSAttributedStringKey.foregroundColor: UIColor.orange
        ]
        setTitleTextAttributes(selectedAttributes, for: .selected)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
