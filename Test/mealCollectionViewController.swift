//
//  mealCollectionViewController.swift
//  FoodTracker
//
//  Created by vpetrenko on 01.12.16.
//  Copyright © 2016 vpetrenko. All rights reserved.
//

import UIKit
import FMMosaicLayout

class mealCollectionViewController: UICollectionViewController {

    
    // MARK: GRID PROPERTIES
    var numberColumnsSection: Int = 2
    var bigImageDividerNumber: Int = 2
    
    // MARK: PROPERTIES
    var imagesArray = [UIImage]()
    let cellSpacing : CGFloat = 2.0
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        let randomBlue = CGFloat(drand48())
        let randomGreen = CGFloat(drand48())
        let randomRed = CGFloat(drand48())
        
        cell.backgroundColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
        // animation of images fade
        cell.alpha = 0.0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIView.animate(withDuration: 0.3, animations: ({
                cell.alpha = 1.0
            }))
        }
        
        // add image
        let imageView = cell.viewWithTag(2) as! UIImageView
        imageView.image = imagesArray[indexPath.row]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: cellSpacing, right: cellSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, interitemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, numberOfColumnsInSection section: Int) -> Int {
        if (imagesArray.count == 1) {
            numberColumnsSection = 1
        }
        
        return numberColumnsSection
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let mosaicLayout: FMMosaicLayout = FMMosaicLayout.init()
        self.collectionView?.collectionViewLayout = mosaicLayout
        
        let imagesArray1 = [#imageLiteral(resourceName: "meal1")]
        let imagesArray2 = [#imageLiteral(resourceName: "meal1"),#imageLiteral(resourceName: "meal1")]
        let imagesArray3 = [#imageLiteral(resourceName: "meal1"),#imageLiteral(resourceName: "meal1"),#imageLiteral(resourceName: "meal1")]
        let imagesArray4 = [#imageLiteral(resourceName: "meal1"),#imageLiteral(resourceName: "meal1"),#imageLiteral(resourceName: "meal1"),#imageLiteral(resourceName: "meal1")]
        
        
        imagesArray = imagesArray3+imagesArray4
        
        initRowsCount()
    }
    
    func initRowsCount () {
        
        let cellSizes = [
            [FMMosaicCellSize.big],
            [FMMosaicCellSize.big, FMMosaicCellSize.big],
            [FMMosaicCellSize.big, FMMosaicCellSize.wide, FMMosaicCellSize.wide],
            [FMMosaicCellSize.big, FMMosaicCellSize.small, FMMosaicCellSize.small, FMMosaicCellSize.wide],
            [FMMosaicCellSize.big, FMMosaicCellSize.small, FMMosaicCellSize.small, FMMosaicCellSize.small, FMMosaicCellSize.small],
            [FMMosaicCellSize.big, FMMosaicCellSize.small, FMMosaicCellSize.small, FMMosaicCellSize.big, FMMosaicCellSize.small,FMMosaicCellSize.small],
            [FMMosaicCellSize.big, FMMosaicCellSize.wide, FMMosaicCellSize.wide, FMMosaicCellSize.big, FMMosaicCellSize.small, FMMosaicCellSize.small, FMMosaicCellSize.wide]
        ]
        
        var rowValue  = [FMMosaicCellSize]()
        var rowsCount = 1
        
        if (imagesArray.count == 1 || imagesArray.count == 2) {
            rowValue = cellSizes[imagesArray.count - 1]
        }
        
        for i in 3...7 {
            if (imagesArray.count % i == 0) {
                rowValue = cellSizes[i - 1]
                rowsCount = imagesArray.count / i
                break
            }
        }
        
        for _ in 0..<rowsCount {
            someInts = someInts + rowValue
        }
    }
    
    var someInts = [FMMosaicCellSize]()
    
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, mosaicCellSizeForItemAt indexPath: IndexPath!) -> FMMosaicCellSize {
        
        if (someInts.count == 0) {
            return FMMosaicCellSize.small
        }
        
        return someInts[indexPath.row]
    }
}
