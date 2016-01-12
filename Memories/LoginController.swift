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
    
    func textFieldDidBeginEditing(textField: UITextField) {
        animateViewMoving(true, moveValue: 100)
    }
    func textFieldDidEndEditing(textField: UITextField) {
        animateViewMoving(false, moveValue: 100)
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:NSTimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = CGRectOffset(self.view.frame, 0,  movement)
        UIView.commitAnimations()
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