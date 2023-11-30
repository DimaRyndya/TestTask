import Foundation

struct DetailPostModel {
    let title: String
    let text: String
    let imageURL: String
}

extension DetailPostModel: Decodable {

    enum CodingKeys: String, CodingKey {
        case title, text
        case imageURL = "postImage"
    }
}
