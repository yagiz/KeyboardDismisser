/*
 MIT License
 
 Copyright (c) 2017 Yagiz Gurgul
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import UIKit

open class KeyboardDismisser : NSObject
{
    public static let shared:KeyboardDismisser = KeyboardDismisser()
    
    
    open var buttonImage: UIImage = UIImage(named: "KeyboardDismisserIcon.png", in: Bundle(for: KeyboardDismisser.self), compatibleWith: nil)!
    open var buttonSize: CGSize = CGSize(width: 30, height: 30)
    open var buttonRightMargin: CGFloat = 10.0
    open var buttonBottomMargin: CGFloat = 10.0
    
    open var isDisabled = false
        {
        didSet
        {
            if self.dismissButton != nil
            {
                self.dismissButton.isHidden = isDisabled
            }
        }
    }
    
    var dismissButton: UIButton! = nil
    var keyboardWindow: UIWindow! = nil
    var isKeyboardShown: Bool = false
    
    open func attach()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        self.removeDismissButton()
        self.createDismissButton()
    }
    
    
    open func detach()
    {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.removeDismissButton()
    }
    
    
    func createDismissButton()
    {
        if self.dismissButton == nil
        {
            self.dismissButton = UIButton(frame: CGRect(x: 0, y: 0, width: self.buttonSize.width, height: self.buttonSize.height))
            self.dismissButton.setImage(self.buttonImage, for: .normal)
            self.dismissButton.addTarget(self, action: #selector(self.dismissButtonAction), for: .touchUpInside)
            self.dismissButton.alpha = 0
        }
    }
    
    
    func removeDismissButton()
    {
        if self.dismissButton != nil
        {
            self.dismissButton.removeFromSuperview()
            self.dismissButton = nil
        }
    }
    
    
    func refreshKeyboardWindow()
    {
        self.keyboardWindow = UIApplication.shared.windows.last!
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification)
    {
        var snapToBeginFrame = false
        
        if self.isKeyboardShown == false
        {
            snapToBeginFrame = true
        }
        
        self.slideDismissButtonWithKeyboard(notification: notification, snapToBeginFrame: snapToBeginFrame, beginAlpha: 0, endAlpha: 1)
        
        self.isKeyboardShown = true
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification)
    {
        var snapToBeginFrame = false
        
        if self.isKeyboardShown == true
        {
            snapToBeginFrame = true
        }
        
        self.slideDismissButtonWithKeyboard(notification: notification, snapToBeginFrame: snapToBeginFrame, beginAlpha: 1, endAlpha: 0)
        
        self.isKeyboardShown = false
    }
    
    
    func slideDismissButtonWithKeyboard(notification: NSNotification, snapToBeginFrame: Bool, beginAlpha: CGFloat, endAlpha: CGFloat)
    {
        if let userInfo = notification.userInfo
        {
            self.refreshKeyboardWindow()
            self.keyboardWindow.addSubview(self.dismissButton)
            
            let beginKeyboardFrame = self.keyboardWindow.convert(((userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue)!,from: nil)
            let endKeyboardFrame = self.keyboardWindow.convert(((userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue)!,from: nil)
            
            
            var dismissButtonFrame = self.dismissButton.frame
            dismissButtonFrame.origin.x = beginKeyboardFrame.size.width - self.dismissButton.frame.size.width - self.buttonRightMargin
            dismissButtonFrame.origin.y = beginKeyboardFrame.origin.y - self.dismissButton.frame.size.height - self.buttonBottomMargin
            
            if snapToBeginFrame == true
            {
                UIView.setAnimationsEnabled(false)
                self.dismissButton.frame = dismissButtonFrame
                self.dismissButton.alpha = beginAlpha
                UIView.setAnimationsEnabled(true)
            }
            
            self.animateWithKeyboardAnimationProperties(userInfo: userInfo, animationBlock: {
                
                var dismissButtonFrame = self.dismissButton.frame;
                dismissButtonFrame.origin.x = endKeyboardFrame.width - self.dismissButton.frame.size.width - self.buttonRightMargin
                dismissButtonFrame.origin.y = endKeyboardFrame.origin.y - self.dismissButton.frame.size.height - self.buttonBottomMargin
                self.dismissButton.frame = dismissButtonFrame
                
                self.dismissButton.alpha = endAlpha
                
            }, completion: { (completed) in
                
                
                
            })
        }
    }
    
    
    func animateWithKeyboardAnimationProperties(userInfo:[AnyHashable : Any], animationBlock:@escaping () -> (), completion: ((Bool) -> Swift.Void)? = nil)
    {
        let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        
        let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        
        let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
        
        UIView.animate(withDuration: duration, delay: TimeInterval(0), options: animationCurve, animations: {
            
            animationBlock()
            
        }, completion: completion)
    }
    
    
    @objc func dismissButtonAction()
    {
        KeyboardDismisser.dismissKeyboard()
    }
    
    
    public static func dismissKeyboard()
    {
        for window in UIApplication.shared.windows
        {
            window.endEditing(true)
        }
    }
}
