//
//  FoodShop.swift
//  NonStop
//
//  Copyright © 2018 Alexandra Klimenko. All rights reserved.
//

import Foundation
import UIKit

class FoodShop {
    var name = "";
    var rating = 0;
    var price = "";
    var imageUrl = "";
    var photo: UIImage?
    var longitude = 0.0;
    var latitude = 0.0;
    
    init?(name: String, rating: Int, price: String, imageUrl: String, longitude: Double, latitude: Double) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.rating = rating
        self.price = price
        self.imageUrl = imageUrl
        self.longitude = longitude
        self.latitude = latitude
        
        self.getPhoto();
    }
    
    private func getPhoto() {
        if let url = URL(string: imageUrl) {
            DispatchQueue.global(qos: .userInitiated).async {
                if let data = try? Data(contentsOf: url) {
                    self.photo = UIImage(data: data)!
                }
            }
        }
    }
}
