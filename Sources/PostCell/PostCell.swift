import UIKit

final class PostCell: UITableViewCell {
    
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var postLikesLabel: UILabel!
    @IBOutlet weak var postTimeLabel: UILabel!
    @IBOutlet weak var postButton: UIButton!
    
    func configure(with post: PostModel) {
        postTitleLabel.text = post.title
        postTextLabel.text = post.text
        postLikesLabel.text = String(post.likes)
        postTimeLabel.text = formatToDays(timeStamp: post.timeStamp)
        post.isTruncated = postTextLabel.isTruncated()
        postButton.isHidden = !post.isTruncated
    }
    
    func formatToDays(timeStamp: Int) -> String {
        let currentDate = Date()        
        let calendar = Calendar.current
        let timestamp = TimeInterval(timeStamp)
        let dateFromTimestamp = Date(timeIntervalSince1970: timestamp)
        var daysLeft = ""
        
        if let daysDiff = calendar.dateComponents([.day], from: dateFromTimestamp, to: currentDate).day {
            daysLeft = String(daysDiff)
        }
        return daysLeft
    }
    
    @IBAction func PostButtonTapped(_ sender: Any) {
        
    }
}
