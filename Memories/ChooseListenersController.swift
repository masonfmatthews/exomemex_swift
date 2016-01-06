import UIKit

class ChooseListenersController: UITableViewController {
    
    var session = SessionController.sharedController.session
    var listeners : [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.leftBarButtonItem = self.editButtonItem() //Wipes out the back button.
        let sendButton = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "sendClip:")
        sendButton.title = "Send"
        self.navigationItem.rightBarButtonItem = sendButton
        
        Thread.runOnBackgroundThread {
            self.listeners = GetListenersApi().getAll()
            self.listeners.sortInPlace({ p1, p2 in p1.name < p2.name })
            Thread.runOnUIThread(self.tableView.reloadData)
        }
    }
    
    func sendClip(sender: AnyObject) {
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listeners.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)as! ChooseListenerCell
        
        let listener = listeners[indexPath.row]
        cell.listenerName.text = "\(listener.name)"
        return cell
    }
    
}
