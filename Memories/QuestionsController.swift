import UIKit

final class QuestionsController: UITableViewController {
    
    var session = SessionController.sharedController.session
    var topic : Topic?
    var questions : [Question] = []
    var newQuestionField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Interview Questions"
        self.tableView.estimatedRowHeight = 100.0;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
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
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! QuestionsCell
        
        let question = questions[indexPath.row]
        cell.questionLabel.text = "\(question.question)"
        cell.questionLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        cell.questionLabel.numberOfLines = 3
        if question.answered {
            cell.checkMark.text = "\u{f00c}"
        } else {
            cell.checkMark.hidden = true
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
}
