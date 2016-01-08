import UIKit

class LandingController: UIViewController {
    
    @IBOutlet weak var listenButton: UIButton!
    @IBOutlet weak var familyButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Journeology"
        
        makeSettingsButton(self.listenButton)
        makeSettingsButton(self.familyButton)
        makeSettingsButton(self.logoutButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func makeSettingsButton(button: UIButton!) {
        let brown = UIColor(red: 134/255, green: 83/255, blue: 39/255, alpha: 1)
        button.setTitleColor(brown, forState: .Normal)
        button.backgroundColor = UIColor.clearColor()
        button.layer.borderWidth = 1
        button.layer.borderColor = brown.CGColor
        button.layer.cornerRadius = 4
    }
    
}