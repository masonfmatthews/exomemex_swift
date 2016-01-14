import UIKit

class QuestionsController: UITableViewController {
    
    var session = SessionController.sharedController.session
    var topic : Topic?
    var questions : [Question] = []
    var newQuestionField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Interview Questions"
        
//        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "newQuestion:")
//        self.navigationItem.rightBarButtonItem = addButton
        Thread.runOnBackgroundThread {
            self.questions = GetTopicApi(topic_id: self.topic!.id).getQuestions()
            Thread.runOnUIThread(self.tableView.reloadData)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "answerQuestion" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let question = questions[indexPath.row]
                let controller = segue.destinationViewController as! RecordController
                controller.question = question
                
                let backItem = UIBarButtonItem()
                backItem.title = "Questions"
                navigationItem.backBarButtonItem = backItem
            }
        }
    }
    
//    func newListener(sender: AnyObject) {
//        let alert = UIAlertController(title: "Add Friend/Family", message: "Please enter name and e-mail address.", preferredStyle: .Alert)
//        
//        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
//        alert.addAction(cancelAction)
//        
//        let nextAction: UIAlertAction = UIAlertAction(title: "Add", style: .Default) { action -> Void in
//            let _ = CreateListenerApi(userFields: ["name": self.newNameField.text!, "email": self.newEmailField.text!],
//                callback: { newListener -> Void in
//                    if newListener == nil {
//                        //TODO: Make this visible to the user.
//                        print("Invalid name or e-mail address!")
//                    } else {
//                        self.listeners.append(newListener!)
//                        self.listeners.sortInPlace({ p1, p2 in p1.name < p2.name })
//                        self.tableView.reloadData()
//                    }
//                }
//            )
//        }
//        
//        alert.addAction(nextAction)
//        
//        //Add text fields
//        alert.addTextFieldWithConfigurationHandler { field -> Void in
//            field.placeholder = "Name"
//            self.newNameField = field
//        }
//        alert.addTextFieldWithConfigurationHandler { field -> Void in
//            field.placeholder = "Email"
//            self.newEmailField = field
//        }
//        
//        //Present the AlertController
//        self.presentViewController(alert, animated: true, completion: nil)
//    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let question = questions[indexPath.row]
        cell.textLabel!.text = "\(question.question)"
        cell.textLabel!.lineBreakMode = NSLineBreakMode.ByWordWrapping
        cell.textLabel!.numberOfLines = 3
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            questions.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
}
