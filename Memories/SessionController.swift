import UIKit

// View controllers can use the shared instance to get the current session.

final class SessionController {
    
    // Set up a singleton instance.
    static let sharedController = SessionController()
    
    // Register a notification.  Used below.
    static let sessionDidChangeNotification = "SessionControllerSessionDidChange"
    
    var session: Session {
        didSet {
            // When the session changes, notify anyone who uses this data.
            let notification = NSNotification(name: SessionController.sessionDidChangeNotification, object: self)
            NSNotificationCenter.defaultCenter().postNotification(notification)
        }
    }
    
    private init() {
        session = Session()
    }
    
}