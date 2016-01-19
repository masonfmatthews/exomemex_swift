import Foundation

final class GetTopicsApi : Api {
    
    var json : [[String: AnyObject]]?
    
    override init() {
        super.init()
        
        if let url = NSURL(string: self.domain + self.path + "topics?token=\(self.session.token!)"),
            data = NSData(contentsOfURL: url) {
                self.json = (try? NSJSONSerialization.JSONObjectWithData(data, options: [])) as? [[String: AnyObject]]
        }
    }
    
    func getCount() -> Int {
        return self.json!.count
    }
    
    func getAll() -> [Topic] {
        if json != nil {
            var topics:[Topic] = []
            for result in json! {
                topics.append(Topic(id: result["id"] as! Int,
                    name: result["name"] as! String,
                    icon: result["icon_code"] as! String
                ))
            }
            return topics
        } else {
            return []
        }
    }
    
}