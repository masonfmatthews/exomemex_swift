import Foundation

class GetClipsApi {
    
    let apiRoot = "https://exomemex-api.herokuapp.com/api/v1/"
    
    var json : [[String: AnyObject]]?
    
    init(userId: Int) {
        if let url = NSURL(string: apiRoot + "clips?user_id=\(userId)"),
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
                clips.append(Clip(id: result["id"] as! Int, name: result["name"] as! String))
            }
            return clips
        } else {
            return []
        }
    }
    
}