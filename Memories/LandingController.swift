import UIKit

class LandingController: UIViewController {
    
    @IBOutlet weak var journalButton: UIButton!
    @IBOutlet weak var interviewButton: UIButton!
    
    @IBOutlet weak var listenButton: UIButton!
    @IBOutlet weak var familyButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Journeology"
        
        Style.primaryButton(self.journalButton)
        Style.primaryButton(self.interviewButton)
        Style.secondaryButton(self.listenButton)
        Style.secondaryButton(self.familyButton)
        Style.secondaryButton(self.logoutButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}