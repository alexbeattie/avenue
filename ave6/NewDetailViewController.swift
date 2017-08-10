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


class NewDetailViewController: UIViewController, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var propName: UILabel!
    @IBOutlet weak var propPrice: UILabel!
    @IBOutlet weak var propImage: UIImageView!
    
    @IBOutlet weak var propDesc: UITextView!
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
//    let website: String? = "fuck"
    
    @IBAction func share(_ sender: Any) {
        let textToShare = "Share this!"
        guard let site = NSURL(string: propObj["url"]! as! String) else { return }
        
        
        
//        guard let site = NSURL(string: "http://artisanbranding.com") else { return }
        let objectsToShare = [textToShare, site] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = sender as? UIView
        activityVC.popoverPresentationController?.barButtonItem = (sender as! UIBarButtonItem)
        self.present(activityVC, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
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
            print(theLocation.latitude, theLocation.longitude)
        }
        let newAnnotation = MKPointAnnotation()
        newAnnotation.coordinate = location
        newAnnotation.title = propObj["name"] as? String
        newAnnotation.subtitle = propObj["cost"] as? String
        mapView.addAnnotation(newAnnotation)
        mapView.selectAnnotation(newAnnotation, animated: true)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140

    }

    var propObj = PFObject(className: "allListings")

   
    override func viewWillAppear(_ animated: Bool) {
        print("Im in View Will Appear")
        super.viewWillAppear(animated)
        self.title = propObj["name"] as? String

//        UINavigationBar.appearance().titleTextAttributes = [
//            NSFontAttributeName: UIFont(name: "Bodoni MT", size: 22)!,
//            NSForegroundColorAttributeName: #colorLiteral(red: 0.1729493737, green: 0.8569635749, blue: 0.8771796823, alpha: 0.5)
//        ]
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
//      self.navigationController?.navigationBar.layer.shadowColor = [UIColor colorWithRed:53.0/255.0 green:108.0/255.0 blue:130.0/255.0 alpha:1.0f].CGColor
    }
    
    
    // start tableview
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as? DescriptionCell else { return UITableViewCell() }
        
        
        cell.propName.text = propObj["name"] as? String
        cell.propCost.text = propObj["cost"] as? String
        cell.propDesc.text = propObj["listingDescription"] as? String
//        cell.propDesc.sizeToFit() 
        

        return cell
        
        //        if let theName = propObj["name"] {
//            self.propName.text = theName as? String
//        }
//        
//        if let theCost = propObj["cost"] {
//            self.propPrice.text = theCost as? String
//        }
//        
//        if let theDesc = propObj["listingDescription"] {
//            self.propDesc.text = theDesc as? String
//        }

        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    
    
    
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annoView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
        annoView.pinTintColor = #colorLiteral(red: 0.5137254902, green: 0.8470588235, blue: 0.8117647059, alpha: 1)
        annoView.animatesDrop = true
        annoView.canShowCallout = true
//        let swiftColor = UIColor(red: 60.0/255.0, green: 109.0/255.0, blue: 109.0/255.0, alpha: 0.80)
        let swiftColor = #colorLiteral(red: 0.5137254902, green: 0.8470588235, blue: 0.8117647059, alpha: 1)
        annoView.centerOffset = CGPoint(x: 100, y: 400)
        annoView.pinTintColor = swiftColor
        
        // Add a RIGHT CALLOUT Accessory
        let rightButton = UIButton(type: UIButtonType.detailDisclosure)
        rightButton.frame = CGRect(x:0, y:0, width:32, height:32)
        rightButton.layer.cornerRadius = rightButton.bounds.size.width/2
        rightButton.clipsToBounds = true
        rightButton.tintColor = #colorLiteral(red: 0.5137254902, green: 0.8470588235, blue: 0.8117647059, alpha: 1)
        
        annoView.rightCalloutAccessoryView = rightButton
        
        
        let leftIconView = UIImageView()
//        leftIconView.image = UIImage(named: "")
        leftIconView.contentMode = .scaleAspectFill
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
//        annoView.sizeToFit()
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
    
    


}
