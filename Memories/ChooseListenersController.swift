import UIKit

class ChooseListenersController: UITableViewController {
    
    var clipName = String()
    var filePath = String()
    var session = SessionController.sharedController.session
    var listeners = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Send to..."
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        let sendButton = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "sendClip:")
        self.navigationItem.rightBarButtonItem = sendButton
        
        Thread.runOnBackgroundThread {
            self.listeners = GetListenersApi().getAll()
            self.listeners.sortInPlace({ p1, p2 in p1.name < p2.name })
            Thread.runOnUIThread(self.tableView.reloadData)
        }
    }
    
    func sendClip(sender: AnyObject) {
        var listenerIds = [Int]()
        for cell in self.tableView.visibleCells {
            let listenerCell = cell as! ChooseListenerCell
            if listenerCell.listenerSwitch.on {
                listenerIds += [Int(listenerCell.listenerId.text!)!]
            }
        }
        let _ = CreateClipApi(clipFields: ["name" : clipName], listenerIds: listenerIds, path: filePath)
        //TODO: Later, display something different if the API returns an error.
        
        performSegueWithIdentifier("finishedClip", sender: self)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listeners.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ChooseListenerCell
        
        let listener = listeners[indexPath.row]
        cell.listenerName.text = "\(listener.name)"
        cell.listenerId.text = "\(listener.id)"
        return cell
    }
    
}
