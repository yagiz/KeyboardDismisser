//
//  ViewController.swift
//  KeyboardDismisserExample
//
//  Created by Yagiz Gurgul on 31/03/2017.
//  Copyright © 2017 Yagiz Gurgul. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        KeyboardDismisser.shared.attach()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

