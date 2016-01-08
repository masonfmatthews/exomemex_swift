import UIKit

class LoginController: UIViewController {
    
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
        
        Style.primaryButton(loginButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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