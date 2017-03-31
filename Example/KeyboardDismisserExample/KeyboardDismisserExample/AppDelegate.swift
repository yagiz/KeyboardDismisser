//
//  AppDelegate.swift
//  KeyboardDismisserExample
//
//  Created by Yagiz Gurgul on 31/03/2017.
//  Copyright © 2017 Yagiz Gurgul. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
                
        KeyboardDismisser.shared.attach()
        
        return true
    }
}

