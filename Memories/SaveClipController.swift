import UIKit

class SaveClipController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var session = SessionController.sharedController.session
    var listeners : [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Thread.runOnBackgroundThread {
            self.listeners = GetListenersApi().getAll()
            Thread.runOnUIThread(self.tableView.reloadData)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listeners.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ListenerTableViewCell
        
        let listener = listeners[indexPath.row]
        cell.label!.text = listener.name
        return cell
    }
    
}
