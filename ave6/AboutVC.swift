//
//  AboutVC.swift
//  ave6
//
//  Created by Alex Beattie on 8/21/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit

class AboutVC: UIViewController, UIGestureRecognizerDelegate {

   
    @IBOutlet weak var moyaAndTere: UIImageView!
    
    func addDoubleTap() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(screenWasDoubleTapped))
        doubleTap.numberOfTapsRequired = 1
        doubleTap.delegate = self
        view.addGestureRecognizer(doubleTap)
    }
    @objc func screenWasDoubleTapped() {
       performSegue(withIdentifier: "toAboutTxt", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDoubleTap()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
