import UIKit

final class ListenersController: UITableViewController {
    
    var session = SessionController.sharedController.session
    var listeners : [User] = []
    var newNameField = UITextField()
    var newEmailField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Friends and Family"
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "newListener:")
        self.navigationItem.rightBarButtonItem = addButton
        Thread.runOnBackgroundThread {
            self.listeners = GetListenersApi().getAll()
            self.listeners.sortInPlace({ p1, p2 in p1.name < p2.name })
            Thread.runOnUIThread(self.tableView.reloadData)
        }
    }
    
    func newListener(sender: AnyObject) {
        let alert = UIAlertController(title: "Add Friend/Family", message: "Please enter name and e-mail address.", preferredStyle: .Alert)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alert.addAction(cancelAction)
        
        let nextAction: UIAlertAction = UIAlertAction(title: "Add", style: .Default) { action -> Void in
            let _ = CreateListenerApi(userFields: ["name": self.newNameField.text!, "email": self.newEmailField.text!],
                callback: { newListener -> Void in
                    if newListener == nil {
                        //TODO: Make this visible to the user.
                        print("Invalid name or e-mail address!")
                    } else {
                        self.listeners.append(newListener!)
                        self.listeners.sortInPlace({ p1, p2 in p1.name < p2.name })
                        self.tableView.reloadData()
                    }
                }
            )
        }
        
        alert.addAction(nextAction)
        
        //Add text fields
        alert.addTextFieldWithConfigurationHandler { field -> Void in
            field.placeholder = "Name"
            self.newNameField = field
        }
        alert.addTextFieldWithConfigurationHandler { field -> Void in
            field.placeholder = "Email"
            self.newEmailField = field
        }
        
        //Present the AlertController
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listeners.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let listener = listeners[indexPath.row]
        cell.textLabel!.text = "\(listener.name)"
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            listeners.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
}
