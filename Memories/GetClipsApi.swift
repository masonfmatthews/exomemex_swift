import Foundation

final class GetClipsApi : Api {
    
    var json : [[String: AnyObject]]?
    
    override init() {
        super.init()
        
        let urlString = self.domain + self.path + "clips?token=\(self.session.token!)"
        if let url = NSURL(string: urlString),
               data = NSData(contentsOfURL: url) {
            self.json = (try? NSJSONSerialization.JSONObjectWithData(data, options: [])) as? [[String: AnyObject]]
        }
    }
    
    func getCount() -> Int {
        return self.json!.count
    }
    
    func getAll() -> [Clip] {
        if json != nil {
            var clips:[Clip] = []
            for result in json! {
                clips.append(Clip(id: result["id"] as! Int, name: result["name"] as! String, url: result["url"] as! String))
            }
            return clips
        } else {
            return []
        }
    }
    
}