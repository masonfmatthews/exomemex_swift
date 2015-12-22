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
    var person = Person(id:0, name: "Error")

    init(personFields: Dictionary<String,String>, callback: (Person) -> Void) {
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
            
            if error != nil {print("Error=\(error)"); return }
            guard let data = data else { print("No response received"); return }
            
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [String: AnyObject]
                if let id = json["id"] as? Int, name = json["name"] as? String {
                    self.person = Person(id: id, name: name)
                    Thread.runOnUIThread {
                        callback(self.person)
                    }
                }
            } catch let parseError as NSError {
                print("Failed to load: \(parseError.localizedDescription)")
            }
        }
        
        task.resume()
    }
}
