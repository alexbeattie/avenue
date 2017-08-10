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

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
//    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        print("preparing")
//        if segue.identifier == "mySegue" {
//            if let cell = sender as? CollectionViewCell {
//                if let index = listingCollectionView!.indexPath(for: cell)?.item {
//                    if let destinationVC = segue.destination as? DetailViewController {
//
//
//                        destinationVC.webSite = (recentListings[index] as AnyObject) as! PFObject
//                        
//                        //                        destinationVC.name = propObj["name"] as? String
//                        print("index")
//                    }
//                }
//            }
//        }
//    }

    
    
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("preparing")
        if segue.identifier == "mySegue" {
            let listingClass = PFObject(className: "allListings")
            

            let cell = sender as? CollectionViewCell
            _ = listingCollectionView!.indexPath(for: cell!)?.item

//            listingClass = recentListings[indexPath.row] as! PFObject

            _ = segue.destination as? NewDetailViewController
//            destinationVC?.webSite = listingClass["name"] as! PFObject
            print(listingClass)
            
                        //                        destinationVC.name = propObj["name"] as? String
                        print("index")
            
        }
    }
    
    var cellSelected : Int = 0
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellSelected = indexPath.item
        print("Did select!")
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
