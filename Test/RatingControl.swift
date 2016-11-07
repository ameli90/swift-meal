//
//  RatingControl.swift
//  FoodTracker
//
//  Created by vpetrenko on 08.11.16.
//  Copyright © 2016 vpetrenko. All rights reserved.
//

import UIKit

class RatingControl: UIView {

    // MARK: Properties
    
    var rating = 0
    var ratingButtons = [UIButton]()
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        button.backgroundColor = UIColor.red
        
        button.addTarget(self, action: #selector(ratingButtonTapped), for: .touchDown)
        
        addSubview(button)
    }
    
    override public var intrinsicContentSize: CGSize {
        get {
            return CGSize(width: 240, height: 44)

        }
    }

    
    // MARK: Button Action
    
    func ratingButtonTapped(button: UIButton) {
        print("Button pressed 👍")
    }
}
