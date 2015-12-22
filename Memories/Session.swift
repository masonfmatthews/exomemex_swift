import Foundation

struct Session {
    let user:Person
    var token:String?
    
    init(user:Person) {
        self.user = user
    }
    
    func getToken() {
        // TODO: hit API with email and password
        // Store token returned by api
        // Store person details returned by api
        // Return something that says whether the login was successful
    }
}