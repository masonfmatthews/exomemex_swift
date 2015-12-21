import Foundation

class GetPeopleApi {
    
    let apiRoot = "https://exomemex-api.herokuapp.com/api/v1/"
    var json : [[String: AnyObject]]?
    
    init() {
        if let url = NSURL(string: apiRoot + "people"),
               data = NSData(contentsOfURL: url) {
            self.json = (try? NSJSONSerialization.JSONObjectWithData(data, options: [])) as? [[String: AnyObject]]
        }
    }
    
    func getFirstName() -> String {
        return self.json![0]["name"] as! String
    }
    
    func getCountOfNames() -> Int {
        return self.json!.count
    }
    
//    func getAllPeople() -> [Person] {
//        if json {
//            var people:[Person] = []
//            for result in list {
//                people.append(Person(id: result["id"] as! Int, name: result["name"] as! String))
//            }
//            return people
//        } else {
//            return []
//        }
//    }
    
}