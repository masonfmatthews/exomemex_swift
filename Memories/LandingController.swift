import UIKit

class LandingController: UIViewController {
    
    var session = SessionController.sharedController.session
    var userApi: GetUserApi?
    
    @IBOutlet weak var journalButton: UIButton!
    @IBOutlet weak var interviewButton: UIButton!
    @IBOutlet weak var interviewLabel: UILabel!
    
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
        
        self.userApi = GetUserApi(user_id: session.id!)
        
        let questionCount = self.userApi!.getOpenQuestionCount()
        if questionCount > 0 {
            self.interviewLabel.text = "(\(questionCount) Questions from Friends and Family)"
        } else {
            self.interviewLabel.text = ""
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}