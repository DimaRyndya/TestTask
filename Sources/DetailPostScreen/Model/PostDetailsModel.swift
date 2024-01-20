import Foundation

final class PostDetailsModel {
    var text: String = ""
    var imageURL: String = ""
    var title: String?
    var likes: String?
    var timestamp: Int?

    init(title: String, likes: String, timestamp: Int) {
        self.title = title
        self.likes = likes
        self.timestamp = timestamp
    }
}

extension PostDetailsModel: Decodable {

    enum CodingKeys: String, CodingKey {
        case text
        case imageURL = "postImage"
    }
}

