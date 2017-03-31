//
//  ViewController.swift
//  KeyboardDismisserExample
//
//  Created by Yagiz Gurgul on 31/03/2017.
//  Copyright © 2017 Yagiz Gurgul. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var disabledTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.disabledTextField.delegate = self
        KeyboardDismisser.shared.attach()
    }

    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        KeyboardDismisser.shared.isDisabled = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        KeyboardDismisser.shared.isDisabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

