import UIKit
import AVFoundation

class RecordViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBAction func resetRecording(sender: AnyObject) {
        self.audioRecorder!.deleteRecording()
    }
    @IBAction func saveRecording(sender: AnyObject) {
        self.audioRecorder!.stop()
        let _ = CreateClipApi(clipFields: ["name" : nameField.text!], path: filePath!)
        //TODO: Later, display something different if the API returns an error.
    }
    
    var filePath : String?
    var audioRecorder : AVAudioRecorder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Are buttons a really lame way to make this work?
        let button = UIButton(type: .Custom) as UIButton
        button.frame = CGRectMake(165, 205, 40, 40)
        button.backgroundColor = UIColor(red: 200, green: 0, blue: 0, alpha: 1)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.addTarget(self, action: "record", forControlEvents: .TouchUpInside)
        view.addSubview(button)
        
        let buttonBorder = UIButton(type: .Custom) as UIButton
        buttonBorder.frame = CGRectMake(150, 190, 70, 70)
        buttonBorder.backgroundColor = UIColor.clearColor()
        buttonBorder.layer.borderColor = UIColor.blackColor().CGColor
        buttonBorder.layer.borderWidth = 1
        buttonBorder.layer.cornerRadius = 0.5 * buttonBorder.bounds.size.width
        buttonBorder.addTarget(self, action: "record", forControlEvents: .TouchUpInside)
        view.addSubview(buttonBorder)
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .ShortStyle
        
        self.nameField.text = formatter.stringFromDate(NSDate())
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func record() {
        //init
        let audioSession:AVAudioSession = AVAudioSession.sharedInstance()
        
        //ask for permission
        if (audioSession.respondsToSelector("requestRecordPermission:")) {
            AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
                if granted {
                    print("granted")
                    
                    //set category and activate recorder session
                    try! audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
                    try! audioSession.setActive(true)
                    
                    //get documnets directory
                    let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
                    self.filePath = documentsDirectory + "/voiceRecording.wav"
                    let url = NSURL.fileURLWithPath(self.filePath!)
                    
                    print(url)
                    
                    //create AnyObject of settings
                    let settings: [String : AnyObject] = [
                        AVFormatIDKey:Int(kAudioFormatLinearPCM), //Int required in Swift2
                        AVSampleRateKey:44100.0,
                        AVNumberOfChannelsKey:1,
                        AVEncoderBitRateKey:12800,
                        AVLinearPCMBitDepthKey:8,
                        AVEncoderAudioQualityKey:AVAudioQuality.Max.rawValue
                    ]
                    
                    //record
                    try! self.audioRecorder = AVAudioRecorder(URL: url, settings: settings)
                    self.audioRecorder!.record()
                    
                } else{
                    print("not granted")
                }
            })
        }
        
    }
    
}