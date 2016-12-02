//
//  imagesCollectionView.swift
//  FoodTracker
//
//  Created by vpetrenko on 02.12.16.
//  Copyright © 2016 vpetrenko. All rights reserved.
//

import UIKit

class imagesCollectionView: UICollectionView {

    
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            return self.contentSize

        }
    }
}
