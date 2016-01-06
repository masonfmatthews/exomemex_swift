import UIKit
import AVFoundation

class PlayClipController: UIViewController {
    
    var clip : Clip?
    var player = AVPlayer()
    
    @IBOutlet weak var playButton: UIButton!
    @IBAction func playClip(sender: AnyObject) {
        self.player.play()
    }
    
    @IBOutlet weak var stopButton: UIButton!
    @IBAction func stopClip(sender: AnyObject) {
        self.player.pause()
        //self.player.seekToTime(CMTime(seconds: 0, preferredTimescale: 1))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = clip!.name
        let url = NSURL(string: clip!.url)
        
        let playerItem = AVPlayerItem(URL: url!)
        self.player = AVPlayer(playerItem: playerItem)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}