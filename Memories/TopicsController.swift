import UIKit

class TopicsController: UITableViewController {
    
    var session = SessionController.sharedController.session
    var topics : [Topic] = []
    var openQuestions : [Question] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Choose a Topic"
        
        Thread.runOnBackgroundThread {
            self.topics = GetTopicsApi().getAll()
            Thread.runOnUIThread(self.tableView.reloadData)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "selectTopic" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let topic = topics[indexPath.row]
                let controller = segue.destinationViewController as! QuestionsController
                controller.topic = topic
                
                let backItem = UIBarButtonItem()
                backItem.title = "Topics"
                navigationItem.backBarButtonItem = backItem
            }
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if openQuestions.count > 0 {
            if section == 0 {
                return "Questions from Friends and Family"
            } else {
                return "Interview Topics"
            }
        } else {
            return nil
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if openQuestions.count > 0 {
            return 2
        } else {
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if openQuestions.count > 0 && section == 0 {
            return openQuestions.count
        } else {
            return topics.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        if openQuestions.count > 0 && indexPath.section == 0 {
            let question = openQuestions[indexPath.row]
            cell.textLabel!.text = "\(question.question)"
        } else {
            let topic = topics[indexPath.row]
            cell.textLabel!.text = "\(topic.name)"
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            topics.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
}
