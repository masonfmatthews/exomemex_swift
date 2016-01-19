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
        self.title = "Impart"
        
        Style.primaryButton(self.journalButton)
        Style.primaryButton(self.interviewButton)
        Style.secondaryButton(self.listenButton)
        Style.secondaryButton(self.familyButton)
        Style.secondaryButton(self.logoutButton)
        
        self.userApi = GetUserApi(user_id: session.id!)
        
        // TODO: Needs to reload when we come BACK to the landing controller.
        let questionCount = self.userApi!.getOpenQuestionCount()
        if questionCount > 0 {
            let word = (questionCount == 1 ? "Question" : "Questions")
            self.interviewLabel.text = "(\(questionCount) \(word) from Friends & Family!)"
            self.interviewLabel.textColor = Style.importantColor
        } else {
            self.interviewLabel.text = ""
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "beInterviewed" {
            let controller = segue.destinationViewController as! TopicsController
            controller.openQuestions = self.userApi!.getOpenQuestions()
        }
    }
    
}