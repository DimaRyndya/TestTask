import UIKit

class PostCell: UITableViewCell {

    @IBOutlet var postTitleLabel: UILabel!
    @IBOutlet var postTextLabel: UILabel!

    func configure(with post: PostModel) {
        postTitleLabel.text = post.title
        postTextLabel.text = post.text
    }
}
