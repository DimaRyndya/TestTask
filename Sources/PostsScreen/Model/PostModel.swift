import Foundation
import UIKit

final class PostModel {
    let id: Int
    let title: String
    let text: String
    let likes: Int
    let timestamp: Int
    var hasButton = true
}

extension PostModel: Decodable {

    enum CodingKeys: String, CodingKey {
        case title
        case id = "postId"
        case text = "preview_text"
        case likes = "likes_count"
        case timestamp = "timeshamp"
    }
}
