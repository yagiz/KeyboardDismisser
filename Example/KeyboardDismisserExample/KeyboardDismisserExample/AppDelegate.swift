//
//  AppDelegate.swift
//  KeyboardDismisserExample
//
//  Created by Yagiz Gurgul on 31/03/2017.
//  Copyright © 2017 Yagiz Gurgul. All rights reserved.
//

import UIKit
import KeyboardDismisser

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        KeyboardDismisser.shared.buttonImage = "keyboardDismissIcon.png"
        KeyboardDismisser.shared.buttonSize = CGSize(width: 30, height: 30)
        KeyboardDismisser.shared.buttonRightMargin = 10
        KeyboardDismisser.shared.buttonBottomMargin = 10
        
        KeyboardDismisser.shared.attach()
        
        return true
    }
}

