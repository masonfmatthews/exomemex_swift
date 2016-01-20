import Foundation

final class GetUserApi : Api {
    
    var json : [String: AnyObject]?
    
    init(user_id : Int) {
        super.init()
        
        let urlString = self.domain + self.path + "users/\(user_id)?token=\(self.session.token!)"
        if let url = NSURL(string: urlString),
            data = NSData(contentsOfURL: url) {
                self.json = (try? NSJSONSerialization.JSONObjectWithData(data, options: [])) as? [String: AnyObject]
        }
    }
    
    func getUser() -> User? {
        if json != nil {
            return User(id: json!["id"] as! Int,
                name: json!["name"] as! String,
                email: json!["email"] as! String)
        } else {
            return nil
        }
    }
    
    func getOpenQuestionCount() -> Int {
        if json != nil {
            let array = json!["open_questions"] as! [[String: AnyObject]]
            return array.count
        } else {
            return 0
        }
    }
    
    func getOpenQuestions() -> [Question] {
        if json != nil {
            var questions:[Question] = []
            let array = json!["open_questions"] as! [[String: AnyObject]]
            for result in array {
                var asker: User?
                let askerDetails = result["asker"] as? [String: AnyObject]
                if askerDetails != nil {
                    asker = User(id: askerDetails!["id"] as! Int,
                        name: askerDetails!["name"] as! String,
                        email: askerDetails!["email"] as! String)
                }
                
                var leadingClip: Clip?
                let clipDetails = result["leading_clip"] as? [String: AnyObject]
                if clipDetails != nil {
                    leadingClip = Clip(id: clipDetails!["id"] as! Int,
                        name: clipDetails!["name"] as! String,
                        url: clipDetails!["url"] as! String)
                }
                questions.append(Question(id: result["id"] as! Int,
                    question: result["question"] as! String,
                    answered: false,
                    asker: asker,
                    leadingClip: leadingClip))
            }
            return questions
        } else {
            return []
        }
    }
    
}