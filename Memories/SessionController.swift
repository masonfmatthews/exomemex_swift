import UIKit

// View controllers can use the shared instance to get the current session.

final class SessionController {
    
    // Set up a singleton instance.
    static let sharedController = SessionController()
    
    private init() {
        let defaults = NSUserDefaults.standardUserDefaults()
        session = Session(id: defaults.objectForKey("id") as? Int, token: defaults.objectForKey("token") as? String)
    }
    
    // Register a notification.  Used below.
    static let sessionDidChangeNotification = "SessionControllerSessionDidChange"
    
    var session: Session {
        didSet {
            // When the session changes, notify anyone who uses this data.
            let notification = NSNotification(name: SessionController.sessionDidChangeNotification, object: self)
            NSNotificationCenter.defaultCenter().postNotification(notification)
        }
    }
    
    func isLoggedIn() -> Bool {
        return !(session.token == nil)
    }
    
    func setIdAndToken(id: Int, token: String) -> Void {
        //TODO: Use keychain access instead?  For security reasons?
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(id, forKey: "id")
        defaults.setObject(token, forKey: "token")
        defaults.synchronize()
        
        self.session = Session(id: id, token: token)
    }
    
    func removeIdAndToken() -> Void {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("id")
        defaults.removeObjectForKey("token")
        defaults.synchronize()
        
        self.session = Session()
        
    }
    
    
}