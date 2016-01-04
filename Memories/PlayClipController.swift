import UIKit

class PlayClipController: UIViewController {
    
    var detailItem : Clip?
    
    @IBOutlet weak var tempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tempLabel.text = detailItem!.url
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}