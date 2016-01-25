import UIKit
import AVFoundation

final class RecordController: UIViewController {
    
    var filePath : String?
    var audioRecorder : AVAudioRecorder?
    var question : Question?
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var innerRecordButton: UIButton!
    @IBOutlet weak var outerRecordButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func resetRecording(sender: AnyObject) {
        self.audioRecorder!.deleteRecording()
        UIApplication.sharedApplication().idleTimerDisabled = false
        
        self.innerRecordButton.layer.removeAllAnimations()
        Style.disabledPrimaryButton(self.saveButton)
        Style.disabledSecondaryButton(self.resetButton)
    }
    
    @IBAction func saveRecording(sender: AnyObject) {
        self.innerRecordButton.layer.removeAllAnimations()
        self.audioRecorder!.stop()
        UIApplication.sharedApplication().idleTimerDisabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New Recording"
        
        Style.disabledPrimaryButton(self.saveButton)
        Style.disabledSecondaryButton(self.resetButton)
        
        //TODO: Are buttons a really lame way to make this record button look nice?
        self.innerRecordButton.setTitle("", forState: .Normal)
        self.innerRecordButton.backgroundColor = UIColor.redColor()
        self.innerRecordButton.layer.cornerRadius = 0.5 * innerRecordButton.bounds.size.width
        self.innerRecordButton.addTarget(self, action: "record", forControlEvents: .TouchUpInside)
        
        self.outerRecordButton.setTitle("", forState: .Normal)
        self.outerRecordButton.backgroundColor = UIColor.clearColor()
        self.outerRecordButton.layer.borderColor = UIColor.blackColor().CGColor
        self.outerRecordButton.layer.borderWidth = 1
        self.outerRecordButton.layer.cornerRadius = 0.5 * outerRecordButton.bounds.size.width
        self.outerRecordButton.addTarget(self, action: "record", forControlEvents: .TouchUpInside)
        
        if self.question == nil {
            self.questionLabel.hidden = true
            let formatter = NSDateFormatter()
            formatter.dateStyle = .LongStyle
            formatter.timeStyle = .NoStyle
            self.nameField.text = formatter.stringFromDate(NSDate())
        } else {
            var labelText = self.question!.question
            if let asker = self.question!.asker {
                labelText += "\n- \(asker.name)"
            }
            self.questionLabel.text = labelText
            self.questionLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
            self.questionLabel.numberOfLines = 4
            self.nameLabel.hidden = true
            self.nameField.text = self.question!.question
            self.nameField.hidden = true
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "doneRecording" {
            let controller = segue.destinationViewController as! ChooseListenersController
            controller.clipName = self.nameField.text!
            controller.filePath = self.filePath!
            controller.question = self.question
        }
    }
    
    func record() {
        //init
        let audioSession:AVAudioSession = AVAudioSession.sharedInstance()
        
        //ask for permission
        if (audioSession.respondsToSelector("requestRecordPermission:")) {
            AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
                if granted {
                    
                    //set category and activate recorder session
                    try! audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
                    try! audioSession.setActive(true)
                    
                    //get documents directory
                    let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
                    self.filePath = documentsDirectory + "/voiceRecording.wav"
                    let url = NSURL.fileURLWithPath(self.filePath!)
                    
                    //create AnyObject of settings
                    let settings: [String : AnyObject] = [
                        AVFormatIDKey:Int(kAudioFormatLinearPCM),
                        AVSampleRateKey:16000.0,
                        AVNumberOfChannelsKey:1,
                        AVLinearPCMBitDepthKey:16
                    ]
                    
                    //record
                    try! self.audioRecorder = AVAudioRecorder(URL: url, settings: settings)
                    self.audioRecorder!.record()
                    
                    UIApplication.sharedApplication().idleTimerDisabled = true
                    
                    Style.primaryButton(self.saveButton)
                    Style.secondaryButton(self.resetButton)
                    
                    let pulseAnimation = CABasicAnimation(keyPath: "opacity")
                    pulseAnimation.duration = 1.2
                    pulseAnimation.fromValue = 0
                    pulseAnimation.toValue = 1
                    pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                    pulseAnimation.autoreverses = true
                    pulseAnimation.repeatCount = FLT_MAX
                    self.innerRecordButton.layer.addAnimation(pulseAnimation, forKey: nil)
                    
                } else{
                    print("Permission not granted!")
                }
            })
        }
        
    }
    
}