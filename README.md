# KeyboardDismisser
KeyboardDismisser is a little Swift 3.0 pod that adds a button over keyboard so that users can dismiss keyboard easily.

### Preview
![](https://github.com/yagiz/KeyboardDismisser/blob/master/Screenshots/preview.gif?raw=true)

### Installation

#### CocoaPods
```sh
pod 'KeyboardDismisser'
```
#### Manually
Just download or clone the repo and move Classes folder to your project.

### Usage
Call ```attach()``` method of singleton KeyboardDismisser instance in ```AppDelegate.swift``` or in any other root class you have.
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
You can change the button image, size or margins. You should do any customisation before calling ```attach()``` method.
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

#### Disabling/Enabling
In some cases you may want to disable KeyboardDismisser. For example if you add custom textfield accessories you may want to disable it. To do so you can use ```isDisabled``` property.
```swift
KeyboardDismisser.shared.isDisabled = true
```

License
----
MIT

**Free Software, Hell Yeah!**