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
    
    var coordinate: CLLocationCoordinate2D
    //        {
    //        set {
    //            self.coordinate = coordinate(latitude: geoPoint.latitude, longitude: geoPoint.longitude)
    //        }
    //        get {
    //            return self.coordinate
    //        }
    //    }
    
    //    var title: String? {
    //        set {
    //            self.title = object["name"] as? String
    //        }
    //
    //        get {
    //            return self.title
    //        }
    //    }
    //
    //    var subtitle: String? {
    //        set {
    //            self.subtitle = object["propDetails"] as? String
    //        }
    //        get {
    //            return self.subtitle
    //        }
    //    }
    init(coordinate: CLLocationCoordinate2D) {
        //      super.init()
        //        self.title = title
        //        self.subtitle = subtitle
        self.coordinate = coordinate
        
    }
    
    
    //    convenience override init(object aObject: PFObject) {
    //        self.init()
    //        self.object = aObject
    //        var geoPoint: PFGeoPoint = self.object["geoPoint"]
    //        self.geoPoint = geoPoint
    //    }
    //
    //    func setGeoPoint(geoPoint: PFGeoPoint) {
    //        self.coordinate = CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude)
    //        self.title = (object["islandName"] as! String)
    //        }
    //
    //    }
}

