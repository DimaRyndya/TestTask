import Foundation

struct DetailPostModel {
    let text: String
    let imageURL: String
}

extension DetailPostModel: Decodable {

    enum CodingKeys: String, CodingKey {
        case text
        case imageURL = "postImage"
    }
}
