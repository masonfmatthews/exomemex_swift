import Foundation

struct Session {
    let user: User
    var token:String?
    
    init(user: User) {
        self.user = user
    }
    
    func getToken() {
        // TODO: hit API with email and password
        // Store token returned by api
        // Store user details returned by api
        // Return something that says whether the login was successful
    }
}