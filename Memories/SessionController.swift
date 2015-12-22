import UIKit

// View controllers can use the shared instance to get the current session.

final class SessionController {
    
    // Register a notification.  Used below.
    static let sessionDidChangeNotification = "SessionControllerSessionDidChange"
    
    var session: Session {
        didSet {
            // When the session changes, notify anyone who uses this data... I don't get this yet.
            let notification = NSNotification(name: SessionController.sessionDidChangeNotification, object: self)
            NSNotificationCenter.defaultCenter().postNotification(notification)
        }
    }
    
    static let sharedController = SessionController()
    
    private init() {
        //TODO: login page!
        session = Session(user: User(id: 1, name:"Mason"))
    }
    
}