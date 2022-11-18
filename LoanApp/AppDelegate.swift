//
//  AppDelegate.swift
//  LoanApp
//
//  Created by Tigran VIasyan on 11.10.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Dependency.shared.initalize()
        return true
        
    }
}

