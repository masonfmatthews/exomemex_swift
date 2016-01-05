import Foundation

final class CreateListenerApi : Api {
    
    var user = User(id:0, name: "Error", email: "email")

    init(userFields: Dictionary<String,String>, callback: (User?) -> Void) {
        super.init()
        
        let request = NSMutableURLRequest(URL: NSURL(string: self.domain + self.path + "listeners")!)
        request.HTTPMethod = "POST"
        
        let params = ["listener": userFields, "token": self.session.token!]
        
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
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [String: AnyObject]
                if let returnedId = json["id"] as? Int,
                  let returnedName = json["name"] as? String,
                  let returnedEmail = json["email"] as? String{
                    Thread.runOnUIThread {
                        let newListener = User(id: returnedId, name: returnedName, email: returnedEmail)
                        
                        callback(newListener)
                    }
                } else {
                    Thread.runOnUIThread {
                        callback(nil)
                    }
                }
            } catch {
                Thread.runOnUIThread {
                    callback(nil)
                }
            }
        }
        
        task.resume()
    }
}
