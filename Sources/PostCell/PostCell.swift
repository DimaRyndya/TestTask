import UIKit

protocol PostCellDelegate: AnyObject {
    func postCellDidChangeHeight(_ cell: PostCell)
}

final class PostCell: UITableViewCell {
    
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var postLikesLabel: UILabel!
    @IBOutlet weak var postTimeLabel: UILabel!
    @IBOutlet weak var postButton: UIButton!

    weak var delegate: PostCellDelegate?

    func configure(with post: PostModel) {
        postTitleLabel.text = post.title
        postTextLabel.text = post.text
        postLikesLabel.text = String(post.likes)
        postTimeLabel.text = formatToDays(interval: post.timestamp)

        if postTextLabel.numberOfLines == 2, !postTextLabel.isTruncated(), post.hasButton {
            postTextLabel.numberOfLines = 0
            postButton.removeFromSuperview()
            post.hasButton = false
        }
    }

    func formatToDays(interval: Int) -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        let timestamp = TimeInterval(interval)
        let dateFromTimestamp = Date(timeIntervalSince1970: timestamp)
        var daysLeft = ""
        
        if let daysDiff = calendar.dateComponents([.day], from: dateFromTimestamp, to: currentDate).day {
            daysLeft = String(daysDiff)
        }
        return daysLeft
    }
    
    @IBAction func PostButtonTapped(_ sender: Any) {
        if postTextLabel.isTruncated() {
            postTextLabel.numberOfLines = postTextLabel.countLabelLines()
            postButton.setTitle("Collapse", for: .normal)
        } else {
            postTextLabel.numberOfLines = 2
            postButton.setTitle("Expand", for: .normal)
        }

        delegate?.postCellDidChangeHeight(self)
    }
}
