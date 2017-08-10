//
//  AppDelegate.swift
//  ave6
//
//  Created by Alex Beattie on 7/15/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit
import Parse


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let parseConfiguration = ParseClientConfiguration(block: { (ParseMutableClientConfiguration) -> Void in
            ParseMutableClientConfiguration.applicationId = "989b4385b24fb1195950a9dcb5c924f0913cac81"
            ParseMutableClientConfiguration.clientKey = "845ecc696bc9f1b80bf345b27956dcdf53d9e7f8"
            ParseMutableClientConfiguration.server = "http://ec2-34-229-57-93.compute-1.amazonaws.com:80/parse"
        })
        
        Parse.initialize(with: parseConfiguration)
        
//
//        UINavigationBar.appearance().titleTextAttributes = [
//            NSFontAttributeName: UIFont(name: "Bodoni MT", size: 22)!,
//            NSForegroundColorAttributeName: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        ]
        
        UINavigationBar.appearance().titleTextAttributes = [
            NSFontAttributeName: UIFont(name: "Bodoni MT", size: 22)!,
            NSForegroundColorAttributeName: #colorLiteral(red: 0.1729493737, green: 0.8569635749, blue: 0.8771796823, alpha: 1)
        ]
//        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.1729493737, green: 0.8569635749, blue: 0.8771796823, alpha: 0.5)
        
//        UINavigationBar.appearance().titleTextAttributes = [
//            NSFontAttributeName: UIFont(name: "Bodoni MT", size: 20)!,
//            NSForegroundColorAttributeName: #colorLiteral(red: 0.1729493737, green: 0.8569635749, blue: 0.8771796823, alpha: 1)
//        ]
        
        
        
        
        
        return true
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

