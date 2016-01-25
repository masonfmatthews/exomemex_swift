import UIKit

final class Style {
    static let primaryColor = UIColor(red: 134/255, green: 83/255, blue: 39/255, alpha: 1)
    static let importantColor = UIColor(red: 24/255, green: 138/255, blue: 39/255, alpha: 1)
    
    class func primaryButton(button: UIButton!) {
        button.enabled = true
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.backgroundColor = primaryColor
        button.layer.cornerRadius = 4
    }
    
    class func secondaryButton(button: UIButton!) {
        button.enabled = true
        button.setTitleColor(primaryColor, forState: .Normal)
        button.backgroundColor = UIColor.clearColor()
        button.layer.borderWidth = 1
        button.layer.borderColor = primaryColor.CGColor
        button.layer.cornerRadius = 4
    }
    
    class func disabledPrimaryButton(button: UIButton!) {
        button.enabled = false
        button.setTitleColor(UIColor.whiteColor(), forState: .Disabled)
        button.backgroundColor = UIColor.lightGrayColor()
        button.layer.cornerRadius = 4
    }
    
    class func disabledSecondaryButton(button: UIButton!) {
        button.enabled = false
        button.setTitleColor(UIColor.lightGrayColor(), forState: .Disabled)
        button.backgroundColor = UIColor.clearColor()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGrayColor().CGColor
        button.layer.cornerRadius = 4
    }
}
