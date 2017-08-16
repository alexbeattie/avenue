//
//  NewAnnotations.swift
//  ave6
//
//  Created by Alex Beattie on 8/13/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import Parse

class NewAnnotations: NSObject, MKAnnotation {
    let object = PFObject()
    let geoPoint = PFGeoPoint()
//    let propImage = UIImage(data: data)
    
    var coordinate: CLLocationCoordinate2D

    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        
    }

}

