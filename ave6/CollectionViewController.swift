//
//  CollectionViewController.swift
//  ave6
//
//  Created by Alex Beattie on 7/15/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit
import Parse


class CollectionViewController: UICollectionViewController {

@IBOutlet weak var listingCollectionView: UICollectionView!

    var recentListings = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()

        let width = collectionView!.frame.width / 3
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        self.title = "Avenue Properties"
        queryAllListings()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func refresh(_ sender: Any) {
        queryAllListings()
        collectionView?.reloadData()
    }

    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentListings.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
//        cell.image.image = nil;
        var listingClass = PFObject(className: "allListings")
        listingClass = recentListings[indexPath.row] as! PFObject
        DispatchQueue.main.async(execute: { () -> Void in
            
            let imageFile = listingClass[PROP_IMAGE] as? PFFile
            imageFile?.getDataInBackground { (imageData, error) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        cell.image.image = UIImage(data: imageData)
                    }else {
                    }
//                    cell.activityIndicator.stopAnimating()
                    
                }
            }
            
        })

    
        if let listingName = listingClass["name"] as? String {
            cell.tName.text = listingName
        }
        
        let formatter = NumberFormatter()
        formatter.usesSignificantDigits = false
        formatter.minimumSignificantDigits = 1
//        formatter.numberStyle = NumberFormatter.
        
        
        if let listingPrice = listingClass["cost"] as? String {
            cell.tPrice.text =  listingPrice
        }
        
        return cell
    }

    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("preparing")
        if segue.identifier == "mySegue" {
            let listingClass = PFObject(className: "allListings")
            

            let cell = sender as? CollectionViewCell
            _ = listingCollectionView!.indexPath(for: cell!)?.item
            _ = segue.destination as? NewDetailViewController
         
            print(listingClass)
            print("index")
            
        }
    }
    
    var cellSelected : Int = 0
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellSelected = indexPath.item
        print("Did select!")
        let barBtn = UIBarButtonItem()
        barBtn.title = ""
        navigationItem.backBarButtonItem = barBtn
        
        var listingClass = PFObject(className: "allListings")
        listingClass = recentListings[indexPath.row] as! PFObject

        let pdVC =  storyboard!.instantiateViewController(withIdentifier: "PropertyDetails") as! NewDetailViewController
        pdVC.propObj = listingClass
        navigationController?.pushViewController(pdVC, animated: true)

    }
    
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        cellSelected = indexPath.item
//        print("Did select!")
//
////        var listingClass = PFObject(className: "allListings")
////        listingClass = recentListings[indexPath.row] as! PFObject
////        
////        let pdVC =  storyboard!.instantiateViewController(withIdentifier: "PropertyDetails") as! NewDetailViewController
//////        pdVC.propObj = listingClass
////        navigationController?.pushViewController(pdVC, animated: true)
//        //        print(listingClass)
//        //        print(addressItems)
//    }
    
    
    
    func queryAllListings() {
        recentListings.removeAllObjects()
        
        let query = PFQuery(className: "allListings")
        query.order(byDescending: "price")
        query.cachePolicy = .networkElseCache
        
        query.findObjectsInBackground { (objects, error) -> Void in
            if error == nil {
                if let objects = objects  {
                    for object in objects {
                        self.recentListings.add(object)
                        print(object)
                    }
                }
                // Reload CollView
                
                
                self.listingCollectionView.reloadData()
//                self.view.hideHUD()
                
            } else {
                print("alex")
                
            } }

    }
}
