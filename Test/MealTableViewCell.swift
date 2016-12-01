//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by vpetrenko on 24.11.16.
//  Copyright © 2016 vpetrenko. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var message: UILabel!
    
    @IBOutlet weak var imagesCollection: UICollectionView!
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCollectionViewDataSourceDelegate (dataDelegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource, forRow row: Int) {
        imagesCollection.delegate = dataDelegate
        imagesCollection.dataSource = dataSource
        imagesCollection.tag = row
        imagesCollection.reloadData()
    }

}
