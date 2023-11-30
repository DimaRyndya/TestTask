import Foundation
import UIKit

struct PostModel {
    let id: Int
    let title: String
    let text: String
}

extension PostModel: Decodable {

    enum CodingKeys: String, CodingKey {
        case title
        case id = "postId"
        case text = "preview_text"
    }
}
