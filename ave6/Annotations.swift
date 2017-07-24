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
    
//    let object = PFObject()
//    let geoPoint = PFGeoPoint()
//    
    var coordinate: CLLocationCoordinate2D

    init(coordinate: CLLocationCoordinate2D) {
//              super.init()
//                self.title = title
//                self.subtitle = subtitle
        self.coordinate = coordinate
        
    }


}
