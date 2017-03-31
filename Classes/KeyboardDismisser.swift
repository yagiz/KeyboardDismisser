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

open class KeyboardDismisser
{
    open static let shared:KeyboardDismisser = KeyboardDismisser()
    
    
    open var buttonImage: UIImage = UIImage(named: "KeyboardDismisserIcon.png", in: Bundle(for: KeyboardDismisser.self), compatibleWith: nil)!
    open var buttonSize: CGSize = CGSize(width: 30, height: 30)
    open var buttonRightMargin: CGFloat = 10.0
    open var buttonBottomMargin: CGFloat = 10.0
    
    open var isDisabled = false
    
    var dismissButton: UIButton! = nil
    var keyboardWindow: UIWindow! = nil
    
    
    open func attach()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.removeDismissButton()
        self.createDismissButton()
    }
    
    
    open func detach()
    {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.removeDismissButton()
    }
    
    
    func createDismissButton()
    {
        if self.dismissButton == nil
        {
            self.dismissButton = UIButton(frame: CGRect(x: 0, y: 0, width: self.buttonSize.width, height: self.buttonSize.height))
            self.dismissButton.setImage(self.buttonImage, for: .normal)
            self.dismissButton.addTarget(self, action: #selector(self.dismissButtonAction), for: .touchUpInside)
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
        self.slideDismissButtonWithKeyboard(notification: notification, beginAlpha: 0, endAlpha: 1)
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification)
    {
        self.slideDismissButtonWithKeyboard(notification: notification, beginAlpha: self.dismissButton.alpha, endAlpha: 0)
    }
    
    
    func slideDismissButtonWithKeyboard(notification: NSNotification, beginAlpha: CGFloat, endAlpha: CGFloat)
    {
        if self.isDisabled == true
        {
            return
        }
        
        if let userInfo = notification.userInfo
        {
            self.refreshKeyboardWindow()
            self.keyboardWindow.addSubview(self.dismissButton)
            
            let beginKeyboardFrame = self.keyboardWindow.convert(((userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue)!,from: nil)
            let endKeyboardFrame = self.keyboardWindow.convert(((userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue)!,from: nil)
            
            
            var dismissButtonFrame = self.dismissButton.frame
            dismissButtonFrame.origin.x = beginKeyboardFrame.size.width - self.dismissButton.frame.size.width - self.buttonRightMargin
            dismissButtonFrame.origin.y = beginKeyboardFrame.origin.y - self.dismissButton.frame.size.height - self.buttonBottomMargin
            
            UIView.setAnimationsEnabled(false)
            self.dismissButton.frame = dismissButtonFrame
            UIView.setAnimationsEnabled(true)
            
            self.dismissButton.alpha = beginAlpha
            
            self.animateWithKeyboardAnimationProperties(userInfo: userInfo)
            {
                var dismissButtonFrame = self.dismissButton.frame;
                dismissButtonFrame.origin.x = endKeyboardFrame.width - self.dismissButton.frame.size.width - self.buttonRightMargin
                dismissButtonFrame.origin.y = endKeyboardFrame.origin.y - self.dismissButton.frame.size.height - self.buttonBottomMargin
                self.dismissButton.frame = dismissButtonFrame
                
                self.dismissButton.alpha = endAlpha
            }
        }
    }
    
    
    func animateWithKeyboardAnimationProperties(userInfo:[AnyHashable : Any], animationBlock:@escaping () -> ())
    {
        let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        
        let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
        
        let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
        
        UIView.animate(withDuration: duration, delay: TimeInterval(0), options: animationCurve, animations: {
            
            animationBlock()
            
        }, completion: nil)
    }
    
    
    @objc func dismissButtonAction()
    {
        KeyboardDismisser.dismissKeyboard()
    }
    
    
    open static func dismissKeyboard()
    {
        UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
