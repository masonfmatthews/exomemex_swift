import UIKit

class PlayClipController: UIViewController {
    
    var detailItem : Clip?
    
    @IBOutlet weak var tempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tempLabel.text = detailItem!.name
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}