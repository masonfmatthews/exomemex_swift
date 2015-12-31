import Foundation

final class CreateClipApi : Api {
    
    init(clipFields: Dictionary<String,String>, path: String) {
        super.init()
        
        let request = NSMutableURLRequest(URL: NSURL(string: self.domain + self.path + "clips")!)
        request.HTTPMethod = "POST"
        
        let params = ["clip": clipFields, "token": self.session.token!]
        
        let boundary = "Boundary-\(NSUUID().UUIDString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
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

        }
        
        task.resume()
    }
}
