//
//  Annotations.swift
//  ave6
//
//  Created by Alex Beattie on 7/23/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit
import MapKit
class Annotations: NSObject, MKAnnotation {

    var coordinate: CLLocationCoordinate2D

    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        
    }


}
