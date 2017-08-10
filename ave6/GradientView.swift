//
//  GradientView.swift
//  parsemasterdetail
//
//  Created by Alex Beattie on 10/31/15.
//  Copyright © 2015 Alex Beattie. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    lazy private var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.clear.cgColor, UIColor(white: 0.0, alpha: 0.75).cgColor]
        layer.locations = [NSNumber(value: 0.0), NSNumber(value: 1.0)]
        return layer
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
}
