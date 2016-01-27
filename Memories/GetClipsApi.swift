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
        guard let json = self.json else { return 0 }
        return json.count
    }
    
    func getAll() -> [Clip] {
        guard json != nil else { return [] }
        var clips:[Clip] = []
        for result in json! {
            guard let id = result["id"] as? Int,
                name = result["name"] as? String,
                url = result["url"] as? String else {continue}
            clips.append(Clip(id: id, name: name, url: url))
        }
        return clips
    }
    
}