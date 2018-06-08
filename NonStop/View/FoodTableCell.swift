//
//  FoodTableCell.swift
//  NonStop
//
//  Copyright © 2018 Alexandra Klimenko. All rights reserved.
//

import Foundation
import UIKit

class FoodTableCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var rating: RatingControl!
    
    override func setSelected(_ selected: Bool, animated: Bool ) {
        super.setSelected(selected, animated: animated)
        
    }
}
