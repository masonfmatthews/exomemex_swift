import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func authenticate(sender: AnyObject) {
        var _ = AuthenticateApi(email: self.emailField.text!,
                password: self.passwordField.text!,
                callback: loginCallback)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SessionController.sharedController.removeIdAndToken()
        
        self.errorLabel.text = ""
        Style.primaryButton(loginButton)
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "adjustForKeyboard:", name: UIKeyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: "adjustForKeyboard:", name: UIKeyboardWillChangeFrameNotification, object: nil)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func adjustForKeyboard(notification: NSNotification) {
        
        if notification.name == UIKeyboardWillHideNotification {
            scrollView.contentInset = UIEdgeInsetsZero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: -150, left: 0, bottom: 0, right: 0)
        }
        
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    private func loginCallback(response: Bool?) {
        if response == nil {
            self.errorLabel.text = "Server is Not Responding"
        } else if response! {
            performSegueWithIdentifier("loginSegue", sender: nil)
        } else {
            self.errorLabel.text = "Incorrect Email or Password"
        }
        
    }
    
}