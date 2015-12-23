import Foundation

class GetUsersApi : Api {
    
    var json : [[String: AnyObject]]?
    
    override init() {
        super.init()
        
        if let url = NSURL(string: self.domain + self.path + "users?token=\(self.session.token!)"),
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