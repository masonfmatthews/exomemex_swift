//
//  RecordViewController.swift
//  Memories
//
//  Created by Mason F. Matthews on 12/18/15.
//  Copyright © 2015 Mason F. Matthews. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController {
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBAction func resetRecording(sender: AnyObject) {
        let alert = UIAlertController(title: "Watch Out!",
            message: "Are you sure that you would like to start recording?",
            preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Close",
            style: UIAlertActionStyle.Destructive,
            handler: nil))
        alert.addAction(UIAlertAction(title: "OK",
            style: UIAlertActionStyle.Default,
            handler: nil))
        self.presentViewController(alert,
            animated: true,
            completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(type: .Custom) as UIButton
        button.frame = CGRectMake(160, 100, 50, 50)
        button.backgroundColor = UIColor(red: 200, green: 0, blue: 0, alpha: 1)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        // button.setImage(UIImage(named:"thumbsUp.png"), forState: .Normal)
        button.addTarget(self, action: "buttonPressed", forControlEvents: .TouchUpInside)
        
        view.addSubview(button)
        
        nameLabel.text = ApiInterface.countPeople()
        nameField.text = ApiInterface.getPeople()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonPressed() {
        print("Round button pressed!")
    }
    
}