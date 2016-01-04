import UIKit
import AVFoundation

class PlayClipController: UIViewController {
    
    var clip : Clip?
    var player = AVPlayer()
    
    @IBOutlet weak var playButton: UIButton!
    @IBAction func playClip(sender: AnyObject) {
//        self.player.play()
    }
    
    @IBOutlet weak var stopButton: UIButton!
    @IBAction func stopClip(sender: AnyObject) {
        //self.player.stop()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: clip!.url)
        
        let playerItem = AVPlayerItem(URL: url!)
        self.player = AVPlayer(playerItem: playerItem)
        self.player.rate = 1.0;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}