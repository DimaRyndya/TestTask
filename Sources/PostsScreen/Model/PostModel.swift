import Foundation
import UIKit

final class PostModel {
    let id: Int
    let title: String
    let text: String
    let likes: Int
    let timestamp: Int
    var isExpanded = false

    var numberOfLines: Int {
        let font = UIFont.systemFont(ofSize: 14)
        let size = CGSize(width: UIScreen.main.bounds.width - 32, height: CGFloat.greatestFiniteMagnitude)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping

        let attributes = [NSAttributedString.Key.font: font,
                          NSAttributedString.Key.paragraphStyle: paragraphStyle.copy()]

        let text = self.text as String
        let rect = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: .none)

        return Int(rect.size.height / font.lineHeight)
    }
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
