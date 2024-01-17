import Foundation

struct DetailPostRequestResponse: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case post
    }
    
    var post: DetailPostModel
}
