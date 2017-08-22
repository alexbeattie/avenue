//
//  AboutTxt.swift
//  ave6
//
//  Created by Alex Beattie on 8/21/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit

class AboutTxt: UIViewController {
 
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
