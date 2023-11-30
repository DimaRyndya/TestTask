import UIKit

class PostCell: UITableViewCell {

    @IBOutlet var postTitleLabel: UILabel!
    @IBOutlet var postTextLabel: UILabel!

//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//    }

    func configure(with post: PostModel) {
        postTitleLabel.text = post.title
        postTextLabel.text = post.text
    }
}
