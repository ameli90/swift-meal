//
//  PinterestLayout.swift
//  Pinterest
//
//  Created by vpetrenko on 29.11.16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit


protocol PinterestLayoutDelegate {
    // 1
    func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:NSIndexPath, withWidth:CGFloat) -> CGFloat
    
}

class PinterestLayoutAttributes: UICollectionViewLayoutAttributes {
    
    // 1
    var photoHeight: CGFloat = 0.0
    
    // 2
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! PinterestLayoutAttributes
        copy.photoHeight = photoHeight
        return copy
    }
    
    // 3
    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? PinterestLayoutAttributes {
            if( attributes.photoHeight == photoHeight  ) {
                return super.isEqual(object)
            }
        }
        return false
    }
}

class PinterestLayout: UICollectionViewLayout {
    
    // 1
    var delegate: PinterestLayoutDelegate!
    
    // 2
    var numberOfColumns = 4
    var cellPadding: CGFloat = 1.0
    
    // 3
    private var cache = [PinterestLayoutAttributes]()
    
    // 4
    private var contentHeight: CGFloat  = 300
    private var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return collectionView!.bounds.width - (insets.left + insets.right)
    }
    
    override func prepare() {
        // 1
        //if cache.isEmpty {
            // 2
            let columnWidth = contentWidth / CGFloat(numberOfColumns)
            var xOffset = [CGFloat]()
            for column in 0 ..< numberOfColumns {
                xOffset.append(CGFloat(column) * columnWidth )
            }
            var column = 0
            var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
            
            // 3
            print(collectionView!.numberOfItems(inSection: 0))
            
            for item in 0 ..< 8 {
                
                let indexPath = NSIndexPath(item: item, section: 0)
                print("INDEX PATH = ", indexPath.row)
                
                // 4
                let width = columnWidth - cellPadding * 2
                let photoHeight = CGFloat(50.0)
                
                let height = cellPadding +  photoHeight + cellPadding
                let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                
                // 5
                let attributes = PinterestLayoutAttributes(forCellWith: indexPath as IndexPath)
                print("PHOTO HEIGHT = ", photoHeight)
                print("TAG = ", collectionView?.tag)
                attributes.photoHeight = photoHeight
                attributes.frame = insetFrame
                cache.append(attributes)
                
                // 6
                contentHeight = max(contentHeight, frame.maxY)
                print("contentHeight=", contentHeight, " yOffset=", yOffset[column])
                yOffset[column] = yOffset[column] + height
                
                column = column >= (numberOfColumns - 1) ? 0 : column + 1
            }

            let heightContraints = NSLayoutConstraint(item: collectionView!, attribute: .height, relatedBy: .equal,
                     toItem: nil,
                     attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0,
                     constant: yOffset[column])
            NSLayoutConstraint.activate([heightContraints])
        
        //}
        
    }

    override var collectionViewContentSize: CGSize {
        print("Sizes: ", contentWidth, contentHeight)
        
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    override class var layoutAttributesClass : AnyClass {
        return PinterestLayoutAttributes.self
    }
}


