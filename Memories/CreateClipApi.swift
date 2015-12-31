import Foundation

final class CreateClipApi : Api {
    
    init(clipFields: Dictionary<String,String>, path: String) {
        super.init()
        
        let request = NSMutableURLRequest(URL: NSURL(string: self.domain + self.path + "clips")!)
        request.HTTPMethod = "POST"
        
        let params = ["clip": clipFields, "token": self.session.token!]
        
//        do {
//            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
//        } catch {
//            request.HTTPBody = nil
//        }
        
        let boundary = "Boundary-\(NSUUID().UUIDString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let body = NSMutableData()
        
        for (key, value) in params {
            if let subhash = value as? Dictionary<String, String> {
                for (subkey, subvalue) in subhash {
                    body.appendString("--\(boundary)\r\n")
                    body.appendString("Content-Disposition: form-data; name=\"\(key)[\(subkey)]\"\r\n\r\n")
                    body.appendString("\(subvalue)\r\n")
                }
            } else {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        let url = NSURL(fileURLWithPath: path)
        let filename = url.lastPathComponent
        let data = NSData(contentsOfURL: url)!
        let mimetype = "audio/wav"
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"clip[clip]\"; filename=\"\(filename!)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.appendData(data)
        body.appendString("\r\n")
        
        body.appendString("--\(boundary)--\r\n")
        
        request.HTTPBody = body
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            (data,response,error) in
            
            if error != nil {print("Error=\(error)"); return }
            guard let _ = data else { print("No response received"); return }
            
            //do {
            //    let json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [String: AnyObject]
            //    if let id = json["id"] as? Int, name = json["name"] as? String {
            //        self.user = User(id: id, name: name)
            //        Thread.runOnUIThread {
            //            callback(self.user)
            //        }
            //    }
            //} catch let parseError as NSError {
            //    print("Failed to load: \(parseError.localizedDescription)")
            //}
        }
        
        task.resume()
    }
}

extension NSMutableData {
    
    /// Append string to NSMutableData
    ///
    /// Rather than littering my code with calls to `dataUsingEncoding` to convert strings to NSData, and then add that data to the NSMutableData, this wraps it in a nice convenient little extension to NSMutableData. This converts using UTF-8.
    ///
    /// - parameter string:       The string to be added to the `NSMutableData`.
    
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}
