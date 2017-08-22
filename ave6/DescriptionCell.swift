//
//  DescriptionCell.swift
//  ave6
//
//  Created by Alex Beattie on 8/10/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit
import Parse

class DescriptionCell: UITableViewCell {

    @IBOutlet weak var propName:UILabel!
    @IBOutlet weak var propCost:UILabel!
    @IBOutlet weak var propDesc:UILabel!
    @IBOutlet weak var playBtn: UIButton!
    
    
    var propObj = PFObject(className: "allListings")

    func updateViews(propName: String, propCost: String, propDesc: String) {
        self.propName.text = propObj["name"] as? String
        self.propCost.text = propObj["cost"] as? String
        self.propDesc.text = propObj["listingDescription"] as? String
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
