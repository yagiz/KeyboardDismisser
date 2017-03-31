# KeyboardDismisser
KeyboardDismisser is a little Swift 3.0 pod that adds a button over keyboard so that users can dismiss keyboard easly.

### Installation

#### CocoaPods
```sh
pod 'KeyboardDismisser'
```
#### Manually
Just download or clone the repo and move Classes folder to your project.

### Usage
Just call ```attach()``` method in AppDelegate.swift or in any other your root class.
```swift

import UIKit
import KeyboardDismisser

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        KeyboardDismisser.shared.attach()
        
        return true
    }
}
```

#### Customizing Dismissing Button
You can change the button image, size or margins. You should do any customisation before calling ```attach()``` method
```swift
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
```



License
----
MIT

**Free Software, Hell Yeah!**