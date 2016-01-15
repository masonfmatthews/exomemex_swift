import Foundation

class Api {
    var session    = SessionController.sharedController.session
    let domain     = "https://impart-api.herokuapp.com/"
    let path       = "api/v1/"
}