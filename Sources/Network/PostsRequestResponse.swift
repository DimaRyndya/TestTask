import Foundation

struct PostsRequestResponse: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case posts
    }
    
    var posts: [PostModel] = []
}
