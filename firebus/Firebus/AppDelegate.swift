//
//  AppDelegate.swift
//  Firebus
//
//  Created by Katherine Fang on 6/24/14.
//  Copyright (c) 2014 Firebase. All rights reserved.
//

import UIKit

@objc(AppDelegate) class AppDelegate : UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var mainViewController: MainViewController?
    
    
    func application(application: UIApplication!, willFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        // Override point for customization with application launch
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            mainViewController = MainViewController(nibName: "FBusMainViewController_iPhone", bundle: nil)
        } else {
            mainViewController = MainViewController(nibName: "FBusMainViewController_iPad", bundle: nil)
        }
        window!.rootViewController = mainViewController
        window!.makeKeyAndVisible()
        return true
    }
}