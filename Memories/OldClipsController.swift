//
//  OldClipsController.swift
//  Memories
//
//  Created by Mason Matthews on 12/22/15.
//  Copyright © 2015 Mason F. Matthews. All rights reserved.
//

import UIKit

class OldClipsController: UITableViewController {
    
    var session = SessionController.sharedController.session
    var clips : [Clip] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Thread.runOnBackgroundThread {
            self.clips = GetClipsApi(userId: self.session.id!).getAll()
            Thread.runOnUIThread(self.tableView.reloadData)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showClip" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let clip = clips[indexPath.row]
                let controller = segue.destinationViewController as! PlayClipController
                controller.clip = clip
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clips.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let clip = clips[indexPath.row]
        cell.textLabel!.text = clip.name
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            clips.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

}
