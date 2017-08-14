//
//  AllListingsMapView.swift
//  ave6
//
//  Created by Alex Beattie on 8/13/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit
import Parse
import MapKit
import CoreLocation

class AllListingsMapView: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate  {

    var propObj = PFObject(className: PROP_CLASS_NAME)
    var annotation:MKAnnotation!
    var pointAnnotation: MKPointAnnotation!
    var pinView:MKPinAnnotationView!

    @IBOutlet weak var mapView: MKMapView!
    var mapItems = NSMutableArray()
    var recentListings = NSMutableArray()
    var locationManager:CLLocationManager!
    @IBOutlet var propImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        allAnnotationsQuery()

    }
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        if mapView.annotations.count != 0 {
            annotation = mapView.annotations[0]
            mapView.removeAnnotation(annotation)
            
        }
        self.title = "All Listings Map"
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let initialLocation = CLLocation(latitude: 47.604147, longitude: -122.334518)
        let regionRadius: CLLocationDistance = 50000
        func centerMapOnLocation(location:CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 5.0, regionRadius * 5.0)
            mapView.setRegion(coordinateRegion, animated: true)
        }
        centerMapOnLocation(location: initialLocation)

    }
    func allAnnotationsQuery() {
        let annotationQuery = PFQuery(className: PROP_CLASS_NAME)
        let swOfSF = PFGeoPoint(latitude:46.623988, longitude:-123.485756)
        let neOfSF = PFGeoPoint(latitude:48.878275, longitude:-120.307961)
        annotationQuery.whereKey("addressItems",withinGeoBoxFromSouthwest: swOfSF, toNortheast: neOfSF)
        annotationQuery.findObjectsInBackground { (objects, error) -> Void in
            if error == nil {
                
                                print("Success")
                let mappedItems = objects! as [PFObject]
                
                for recipe in mappedItems {
                    let point = recipe["addressItems"] as! PFGeoPoint
                    let theTitle = recipe["name"] as! String
                    let subTitle = recipe["cost"] as! String
                    
                    if let thumbImage = self.propObj["imageFile"] as? PFFile {
                        thumbImage.getDataInBackground() { (imageData, error) -> Void in
                            if error == nil {
                                if let imageData = imageData {
                                    self.propImage.image = UIImage(data:imageData)
                                    print(self.propImage.image)

                                }
                            }
                        }
                    }
                    
                               print("This is \(recipe)")
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2DMake(point.latitude, point.longitude)
                    annotation.title = theTitle
                    annotation.subtitle = subTitle
                
                    self.mapView.addAnnotation(annotation)
                }
            } else {
                print(error!)
            } }
    }
 
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let propObj = PFObject(className: PROP_CLASS_NAME)

        let annoView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
        let swiftColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        
        annoView.pinTintColor = swiftColor
        annoView.animatesDrop = true
        annoView.canShowCallout = true
        
        
        let leftIconView = UIImageView()
        leftIconView.contentMode = .scaleAspectFill
        
        
        
        if let thumbImage = propObj["imageFile"] as? PFFile {
            thumbImage.getDataInBackground() { (imageData, error) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        print(imageData)
                        leftIconView.image = UIImage(data:imageData)
                        
                        
                    }
                }
            }
        }
        
        let newBounds = CGRect(x:0.0, y:0.0, width:54.0, height:54.0)
        leftIconView.bounds = newBounds
        annoView.leftCalloutAccessoryView = leftIconView
        
        
        
        
        
        let rightButton = UIButton(type: UIButtonType.detailDisclosure)
        rightButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        rightButton.layer.cornerRadius = rightButton.bounds.size.width/2
        rightButton.clipsToBounds = true
        annoView.rightCalloutAccessoryView = rightButton
        
        
        
        return annoView
        
    }
}
