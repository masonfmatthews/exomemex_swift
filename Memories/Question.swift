import Foundation

struct Question {
    let id : Int
    let question : String
    let asker : User?
    let leadingClip : Clip?
}