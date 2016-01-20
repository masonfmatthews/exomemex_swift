import UIKit

// View controllers can use the shared instance to get the current session.

final class SessionController {
    
    // Set up a singleton instance.
    static let sharedController = SessionController()
    
    private init() {
        if (Keychain.load("id") == nil || Keychain.load("token") == nil) {
            session = Session()
        } else {
            let id = Int(String(data: Keychain.load("id")!, encoding: NSUTF8StringEncoding)!)
            print(id)
            let token = String(data: Keychain.load("token")!, encoding: NSUTF8StringEncoding)
            print(token)
            session = Session(id: id, token: token)
        }
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
        Keychain.save("id", data: "\(id)".dataUsingEncoding(NSUTF8StringEncoding)!)
        Keychain.save("token", data: token.dataUsingEncoding(NSUTF8StringEncoding)!)
        
        self.session = Session(id: id, token: token)
    }
    
    func removeIdAndToken() -> Void {
        Keychain.delete("id")
        Keychain.delete("token")
        
        self.session = Session()
        
    }
    
    
}