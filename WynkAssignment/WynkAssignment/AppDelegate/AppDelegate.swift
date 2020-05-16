//
//  AppDelegate.swift
//  WynkAssignment
//
//  Created by Admin on 14/05/20.
//  Copyright © 2020 Nitin Singh Rathore. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        /*
         routing to initial viewcontroller after launch
         */
        NavigationRouter.shared.initialViewController(window: window)
        
        return true
    }
    
    
}

