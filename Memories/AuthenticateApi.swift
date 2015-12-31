import Foundation

final class AuthenticateApi : Api {
    
    init(email: String, password: String, callback: (Bool?) -> Void) {
        super.init()
        
        let request = NSMutableURLRequest(URL: NSURL(string: self.domain + "login")!)
        let params = ["email": email, "password": password]
        request.HTTPMethod = "POST"
        
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
                if let returnedId = json["id"] as? Int, let returnedToken = json["token"] as? String {
                    Thread.runOnUIThread {
                        // TODO: WTF?  Why do I have to give only one of the paramaters a keyword?
                        SessionController.sharedController.setIdAndToken(returnedId, token: returnedToken)
                        
                        callback(true)
                    }
                } else {
                    callback(nil)
                }
            } catch {
                Thread.runOnUIThread {
                    callback(false)
                }
            }
        }
        
        task.resume()
    }
}
