//
//  NewDetailViewController.swift
//  ave6
//
//  Created by Alex Beattie on 7/23/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit
import Parse
import MapKit

class NewDetailViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var propName: UILabel!
    @IBOutlet weak var propPrice: UILabel!
    @IBOutlet weak var propImage: UIImageView!

    @IBOutlet var mapView: MKMapView!
    @IBAction func goMainMap(sender: AnyObject) {
        performSegue(withIdentifier: "allListingsMap", sender: self)
    }
    @IBAction func goToMap(sender: AnyObject) {
        performSegue(withIdentifier: "allListingsMap", sender: self)
    }
    
    var listingClass = PFObject(className: "allListings")
    var addressItems = PFGeoPoint()

    var annotation:MKAnnotation!
    var pointAnnotation:MKPointAnnotation!
    var pinView:MKPinAnnotationView!
    var region: MKCoordinateRegion!
    var mapType: MKMapType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if mapView.annotations.count != 0 {
            annotation = mapView.annotations[0]
            mapView.removeAnnotation(annotation)
            
        }
        self.mapView.delegate = self
        
        let addressItems = PFGeoPoint(latitude: (propObj["addressItems"] as AnyObject).latitude, longitude: (propObj["addressItems"] as AnyObject).longitude)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake((propObj["addressItems"] as AnyObject).latitude, (propObj["addressItems"] as AnyObject).longitude)
        mapView.region = MKCoordinateRegionMakeWithDistance(
            CLLocationCoordinate2DMake(addressItems.latitude, addressItems.longitude), 27500, 27500);
        
        mapView.setRegion(mapView.region, animated: true)
        
        
        if let theLocation = propObj["addressItems"] as? PFGeoPoint {
            CLLocationCoordinate2DMake(addressItems.latitude, addressItems.longitude)
            print(theLocation)
        }
        let newAnnotation = MKPointAnnotation()
        newAnnotation.coordinate = location
        newAnnotation.title = propObj["name"] as? String
        newAnnotation.subtitle = propObj["cost"] as? String
        mapView.mapType = MKMapType.hybridFlyover
        mapView.showsPointsOfInterest = true
        mapView.addAnnotation(newAnnotation)
        mapView.selectAnnotation(newAnnotation, animated: true)
        
    }

    var propObj = PFObject(className: "allListings")

    override func viewWillAppear(_ animated: Bool) {
        print("Im Here")
        super.viewWillAppear(animated)
        
        if let theName = propObj["name"] {
            self.propName.text = theName as? String
            }
        if let theCost = propObj["cost"] {
            self.propPrice.text = theCost as? String
            }

        if let imageFile = self.propObj["imageFile"] as? PFFile {
            imageFile.getDataInBackground { (imageData, error) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        self.propImage.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
    
    
//    Map
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annoView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
        annoView.pinTintColor = UIColor.blue
        annoView.animatesDrop = true
        annoView.canShowCallout = true
        let swiftColor = UIColor(red: 60.0/255.0, green: 109.0/255.0, blue: 109.0/255.0, alpha: 0.80)
        
        annoView.pinTintColor = swiftColor
        
        // Add a RIGHT CALLOUT Accessory
        let rightButton = UIButton(type: UIButtonType.detailDisclosure)
        rightButton.frame = CGRect(x:0, y:0, width:32, height:32)
        rightButton.layer.cornerRadius = rightButton.bounds.size.width/2
        rightButton.clipsToBounds = true
        annoView.rightCalloutAccessoryView = rightButton
        
        
        let leftIconView = UIImageView()
        leftIconView.image = UIImage(named: "")
        if let thumbImage = propObj["imageFile"] as? PFFile {
            thumbImage.getDataInBackground() { (imageData, error) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        leftIconView.image = UIImage(data:imageData)


                    }
                }
            }
        }
        
        
        let newBounds = CGRect(x:0.0, y:0.0, width:54.0, height:54.0)
        leftIconView.bounds = newBounds
        annoView.sizeToFit()
        annoView.leftCalloutAccessoryView = leftIconView
        
        
        return annoView
        
    }
    
    func goOutToGetMap() {
        let addressItems = PFGeoPoint(latitude: (self.propObj["addressItems"] as AnyObject).latitude, longitude: (self.propObj["addressItems"] as AnyObject).longitude)
        if let theLocation = self.propObj["addressItems"] as? PFGeoPoint {
            CLLocationCoordinate2DMake(addressItems.latitude, addressItems.longitude)
            print(theLocation)
        }
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake((self.propObj["addressItems"] as AnyObject).latitude, (self.propObj["addressItems"] as AnyObject).longitude)
        
        let placemark = MKPlacemark(coordinate: location, addressDictionary: nil)
        
        let item = MKMapItem(placemark: placemark)
        //        let camera = MKMapCamera(lookingAtCenterCoordinate: location, fromEyeCoordinate: location, eyeAltitude: 80000)
        item.name = self.propObj["name"] as? String
        item.openInMaps (launchOptions: [MKLaunchOptionsMapTypeKey: 2,
                                           MKLaunchOptionsMapCenterKey:NSValue(mkCoordinate: placemark.coordinate),
                                           MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving])
        
        
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        
            let alertController = UIAlertController(title: nil, message: "Driving directions", preferredStyle: .actionSheet)
            let OKAction = UIAlertAction(title: "Get Directions", style: .default) { (action) in
                self.goOutToGetMap()
            }
            alertController.addAction(OKAction)
            
            
            
            
            present(alertController, animated: true) {
                
                
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                
            }
            alertController.addAction(cancelAction)
        }
    
            
//            performSegueWithIdentifier("goToPop", sender: self)
    
            
    
        

}
