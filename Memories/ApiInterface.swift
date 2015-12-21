import Foundation

let apiRoot = "https://exomemex-api.herokuapp.com/api/v1/"

class ApiInterface {
    
    class func getPeople() -> String {
        if let
            url = NSURL(string: apiRoot + "people"),
            data = NSData(contentsOfURL: url),
            list = (try? NSJSONSerialization.JSONObjectWithData(data, options: [])) as? [[String: AnyObject]]
        {
//            var people:[Person] = []
//            for result in list {
//                people.append(Person(id: result["id"] as! Int, name: result["name"] as! String))
//            }
//            return people
            return list[0]["name"] as! String
        } else {
            return "(No User)"
        }
    }
    
}