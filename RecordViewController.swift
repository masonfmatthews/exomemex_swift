import UIKit

class RecordViewController: UIViewController {
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBAction func resetRecording(sender: AnyObject) {
        CreateUserApi(userFields: ["name": nameField.text!, "email": "test@test.com"], callback: createUserCallback)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(type: .Custom) as UIButton
        button.frame = CGRectMake(160, 100, 50, 50)
        button.backgroundColor = UIColor(red: 200, green: 0, blue: 0, alpha: 1)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        // button.setImage(UIImage(named:"thumbsUp.png"), forState: .Normal)
        button.addTarget(self, action: "buttonPressed", forControlEvents: .TouchUpInside)
        
        view.addSubview(button)
        let users = GetUsersApi()
        nameLabel.text = "There are \(users.getCount()) names."
        nameField.text = users.getFirstName()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonPressed() {
        print("Round button pressed!")
    }
    
    private func createUserCallback(user: User) {
        self.nameLabel.text = "\(user.id)"
    }
    
}