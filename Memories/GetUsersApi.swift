import Foundation

class GetUsersApi {
    
    let apiRoot = "https://exomemex-api.herokuapp.com/api/v1/"
    var json : [[String: AnyObject]]?
    
    init() {
        if let url = NSURL(string: apiRoot + "users"),
               data = NSData(contentsOfURL: url) {
            self.json = (try? NSJSONSerialization.JSONObjectWithData(data, options: [])) as? [[String: AnyObject]]
        }
    }
    
    func getFirstName() -> String {
        return self.json![0]["name"] as! String
    }
    
    func getCount() -> Int {
        return self.json!.count
    }
    
}