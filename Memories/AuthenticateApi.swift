import Foundation

class AuthenticateApi {
    
    var token : String?
    
    init(email: String, password: String, callback: (String?) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: "https://exomemex-api.herokuapp.com/login")!)
        request.HTTPMethod = "POST"
        
        let params = ["email": email, "password": password]
        
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
                if let token = json["token"] as? String {
                    self.token = token
                    Thread.runOnUIThread {
                        callback(self.token)
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
