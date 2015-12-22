//
//  PostPersonApi.swift
//  Memories
//
//  Created by Mason Matthews on 12/21/15.
//  Copyright © 2015 Mason F. Matthews. All rights reserved.
//

import Foundation

class PostPersonApi {
    
    let apiRoot = "https://exomemex-api.herokuapp.com/api/v1/"

    init(personFields: Dictionary<String,String>, callback: (String) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: apiRoot + "people")!)
        request.HTTPMethod = "POST"
        
        let params = ["person":personFields]
        
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
        } catch {
            request.HTTPBody = nil
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            (data,response,error) in
            
            guard let data = data else { print("No response received"); return }
            
            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
            
            if error != nil {
                print("Error=\(error)")
                return
            }
            print("response = \(response)")
            print("responseString = \(responseString)")
            Thread.runOnUIThread {
                callback("Record was saved successfully!")
            }
        }
        
//        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
//            print("Response: \(response)")
//            let body = NSString(data: data!, encoding: NSUTF8StringEncoding)
//            print("Body: \(body)")
//            let err: NSError?
//            var json : NSDictionary?
//            do {
//                json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
//            }
//            
//            if(err != nil) {
//                print(err!.localizedDescription)
//                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
//                print("Error could not parse JSON: '\(jsonStr)'")
//            } else {
//                if let parseJSON = json {
//                    let id = parseJSON["id"] as? Int
//                    print("Success!  New id: \(id)")
//                    completionHandler(id!, personParams["name"]!)
//                }
//                else {
//                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
//                    print("Error could not parse JSON: \(jsonStr)")
//                }
//            }
//        })
        
        print("Request started.")
        task.resume()
        print("Request done.")
    }
}
