import Foundation

final class CreateListenerApi : Api {
    
    var user = User(id:0, name: "Error", email: "email")

    init(userFields: Dictionary<String,String>, callback: (User) -> Void) {
        super.init()
        
        let request = NSMutableURLRequest(URL: NSURL(string: self.domain + self.path + "listeners")!)
        request.HTTPMethod = "POST"
        
        let params = ["user": userFields, "token": self.session.token!]
        
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
        } catch {
            request.HTTPBody = nil
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            (data,response,error) in
            
            if error != nil {print("Error=\(error)"); return }
            guard let _ = data else { print("No response received"); return }
        }
        
        task.resume()
    }
}
