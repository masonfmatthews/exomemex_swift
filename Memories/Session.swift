import Foundation

struct Session {
    let user: User
    var token:String?
    
    init(user: User) {
        self.user = user
    }
}