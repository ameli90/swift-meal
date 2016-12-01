//
//  Meal.swift
//  FoodTracker
//
//  Created by vpetrenko on 23.11.16.
//  Copyright © 2016 vpetrenko. All rights reserved.
//

import UIKit

class Meal: NSObject, NSCoding {

    // MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    var message: String?
    var collection: [UIImage]?
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("meals")
    
    // MARK: Types
    struct PropertyKey {
        static let nameKey = "name"
        static let photoKey = "photo"
        static let ratingKey = "rating"
        static let messageKey = "message"
        static let collectionKey = "collection"
    }
    
    // MARK: NSCoding
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(photo, forKey: PropertyKey.photoKey)
        aCoder.encode(rating, forKey: PropertyKey.ratingKey)
        aCoder.encode(message, forKey: PropertyKey.messageKey)
        aCoder.encode(collection, forKey: PropertyKey.collectionKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        // Because photo is an optional property of Meal, use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photoKey) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.ratingKey)
        let message = aDecoder.decodeObject(forKey: PropertyKey.messageKey) as? String
        
        let collection = aDecoder.decodeObject(forKey: PropertyKey.collectionKey) as? [UIImage]
        // Must call designated initializer.
        self.init(name: name, photo: photo, rating: rating, message: message, collection: collection)
    }
    
    
    // MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int, message: String?, collection: [UIImage]?) {
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
        self.message = message
        self.collection = collection
        
        super.init()
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || rating < 0 {
            return nil
        }
    }

}
