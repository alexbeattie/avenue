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
        
        //cell.image.image = nil;
        
        var listingClass = PFObject(className: "allListings")
        listingClass = recentListings[indexPath.row] as! PFObject
        DispatchQueue.main.async(execute: { () -> Void in
            
            let imageFile = listingClass[PROP_IMAGE] as? PFFile
            imageFile?.getDataInBackground { (imageData, error) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        cell.image.image = UIImage(data: imageData)
                    }
                    //cell.activityIndicator.stopAnimating()
                }
            }
        })
        if let listingName = listingClass["name"] as? String {
            cell.tName.text = listingName
        }
        
        let formatter = NumberFormatter()
        formatter.usesSignificantDigits = false
        formatter.minimumSignificantDigits = 1
        //formatter.numberStyle = NumberFormatter.
        
        if let listingPrice = listingClass["cost"] as? String {
            cell.tPrice.text =  listingPrice
        }
        
        return cell
    }
    
    var cellSelected : Int = 0
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellSelected = indexPath.item
        print("Did select!")
        let barBtn = UIBarButtonItem()
        barBtn.title = ""
        navigationItem.backBarButtonItem = barBtn
        
        var listingClass = PFObject(className: PROP_CLASS_NAME)
        listingClass = recentListings[indexPath.row] as! PFObject

        let pdVC =  storyboard!.instantiateViewController(withIdentifier: "PropertyDetails") as! NewDetailViewController
        pdVC.propObj = listingClass
        navigationController?.pushViewController(pdVC, animated: true)

    }
    

    
    func queryAllListings() {
        recentListings.removeAllObjects()
        
        let query = PFQuery(className: PROP_CLASS_NAME)
        
        query.order(byDescending: "price")
        query.cachePolicy = .networkElseCache
        
        query.findObjectsInBackground { (objects, error) -> Void in
            if error == nil {
                if let objects = objects  {
                    for object in objects {
                        self.recentListings.add(object)
                       // print(object)
                    }
                }
                self.listingCollectionView.reloadData()
                //self.view.hideHUD()
            } else {
                print("alex")
                
            }
        }
    }
}
