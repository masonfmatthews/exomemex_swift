import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBAction func authenticate(sender: AnyObject) {
        AuthenticateApi(email: self.emailField.text!,
                password: self.passwordField.text!,
                callback: loginCallback)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func loginCallback(token: String?) {
        if token == nil {
            self.errorLabel.text = "Incorrect Email or Password"
        } else {
            self.errorLabel.text = token
        }
        
    }
    
}