//
//  OldClipsController.swift
//  Memories
//
//  Created by Mason Matthews on 12/22/15.
//  Copyright © 2015 Mason F. Matthews. All rights reserved.
//

import UIKit

class ListenersController: UITableViewController {
    
    var session = SessionController.sharedController.session
    var listeners : [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "newListener:")
        self.navigationItem.rightBarButtonItem = addButton
        Thread.runOnBackgroundThread {
            self.listeners = GetListenersApi().getAll()
            Thread.runOnUIThread(self.tableView.reloadData)
        }
    }
    
    func newListener(sender: AnyObject) {
        let alert = UIAlertController(title: "Add Friend/Family", message: "Please enter name and e-mail address.", preferredStyle: .Alert)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alert.addAction(cancelAction)
        
        let nextAction: UIAlertAction = UIAlertAction(title: "Add", style: .Default) { action -> Void in
            //NEXT TODO: Do stuff
        }
        
        alert.addAction(nextAction)
        
        //Add text fields
        alert.addTextFieldWithConfigurationHandler { textField -> Void in
            textField.placeholder = "Name"
        }
        alert.addTextFieldWithConfigurationHandler { textField -> Void in
            textField.placeholder = "Email"
        }
        
        //Present the AlertController
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
//    func addCompletionHandler(id: Int, name: String, email: String) {
//        let newListener = User(id: id, name: name, email: email)
//        Thread.runOnUIThread {
//            self.listeners.append(newListener)
//            self.listeners.sortInPlace({ p1, p2 in p1.name < p2.name })
//            self.tableView.reloadData()
//        }
//    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listeners.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let listener = listeners[indexPath.row]
        cell.textLabel!.text = "\(listener.name): (\(listener.email))"
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
