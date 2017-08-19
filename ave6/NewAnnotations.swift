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
    let title:String?
    
    var coordinate: CLLocationCoordinate2D

    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
//    init(coordinate: CLLocationCoordinate2D) {
//        self.coordinate = coordinate
//        
//    }

}

