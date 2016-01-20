import Foundation

struct Question {
    let id : Int
    let question : String
    var answered : Bool
    var asker : User?
    var leadingClip : Clip?
}