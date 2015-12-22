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
        PostPersonApi(personFields: ["name": nameField.text!], callback: {label -> Void in self.nameLabel.text = label})
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
        let people = GetPeopleApi()
        nameLabel.text = "There are \(people.getCountOfNames()) names."
        nameField.text = people.getFirstName()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonPressed() {
        print("Round button pressed!")
    }
    
}