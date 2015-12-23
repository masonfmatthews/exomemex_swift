import Foundation

class CreateUserApi : Api {
    
    var user = User(id:0, name: "Error")

    init(userFields: Dictionary<String,String>, callback: (User) -> Void) {
        super.init()
        
        let request = NSMutableURLRequest(URL: NSURL(string: self.domain + self.path + "users")!)
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
            guard let data = data else { print("No response received"); return }
            
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [String: AnyObject]
                if let id = json["id"] as? Int, name = json["name"] as? String {
                    self.user = User(id: id, name: name)
                    Thread.runOnUIThread {
                        callback(self.user)
                    }
                }
            } catch let parseError as NSError {
                print("Failed to load: \(parseError.localizedDescription)")
            }
        }
        
        task.resume()
    }
}
