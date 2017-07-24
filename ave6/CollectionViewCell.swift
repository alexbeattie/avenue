//
//  CollectionViewCell.swift
//  ave6
//
//  Created by Alex Beattie on 7/15/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit
import Parse

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tName: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var tPrice: UILabel!
//    @IBOutlet weak var gradientView: GradientView!
    
    override func prepareForReuse() {
        image.image = nil
    }

}
