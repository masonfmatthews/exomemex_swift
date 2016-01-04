import Foundation

final class GetListenersApi : Api {
    
    var json : [[String: AnyObject]]?
    
    override init() {
        super.init()
        
        if let url = NSURL(string: self.domain + self.path + "listeners?token=\(self.session.token!)"),
               data = NSData(contentsOfURL: url) {
            self.json = (try? NSJSONSerialization.JSONObjectWithData(data, options: [])) as? [[String: AnyObject]]
        }
    }
    
    func getCount() -> Int {
        return self.json!.count
    }
    
    func getAll() -> [User] {
        if json != nil {
            var users:[User] = []
            for result in json! {
                users.append(User(id: result["id"] as! Int, name: result["name"] as! String, email: result["email"] as! String))
            }
            return users
        } else {
            return []
        }
    }
    
}