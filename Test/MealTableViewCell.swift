//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by vpetrenko on 24.11.16.
//  Copyright © 2016 vpetrenko. All rights reserved.
//

import UIKit
import FTImageViewer

class MealTableViewCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var message: UILabel!
    
    @IBOutlet weak var imageGridHeight: NSLayoutConstraint!

    @IBOutlet weak var imageGridView: FTImageGridView!
    
    
    var imageArray : [String] = []{
        didSet {
            
            // set width for the image grid
            // 56 is the leading constraint for the grid in storyboard
            // 8 is the trailing constraint for the grid in storyboard
            // or set the width to a certain value in storyboard and leave the calculation to `FTImageGridView`
            let gridWidth = UIScreen.main.bounds.size.width - 8 - 8
            
            
            // get height for the image grid
            imageGridHeight.constant = FTImageGridView.getHeightWithWidth(gridWidth, imgCount: imageArray.count)
            
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // show images in grid
        imageGridView.showWithImageArray(imageArray) { (buttonsArray, buttonIndex) in
            // preview images with one line of code
            FTImageViewer.sharedInstance.showImages(self.imageArray, atIndex: buttonIndex, fromSenderArray: buttonsArray)
        }
    }

}
