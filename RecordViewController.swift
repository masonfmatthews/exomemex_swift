import UIKit

class RecordViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBAction func resetRecording(sender: AnyObject) {
        self.nameField.text = ""
    }
    @IBAction func saveRecording(sender: AnyObject) {
        CreateClipApi(clipFields: ["name" : nameField.text!])
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
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func buttonPressed() {
        print("Round button pressed!")
    }
    
}