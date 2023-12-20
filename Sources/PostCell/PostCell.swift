import UIKit

class PostCell: UITableViewCell {

    @IBOutlet var postTitleLabel: UILabel!
    @IBOutlet var postTextLabel: UILabel!
    @IBOutlet var postLikesLabel: UILabel!
    @IBOutlet var postTimeLabel: UILabel!

    func configure(with post: PostModel) {
        postTitleLabel.text = post.title
        postTextLabel.text = post.text
        postLikesLabel.text = String(post.likes)
        postTimeLabel.text = formatToDays(timeStamp: post.timeStamp)
    }

    func formatToDays(timeStamp: Int) -> String {
        let currentDate = Date()
//        let dateComponents = DateComponents(second: timestamp)
        let calendar = Calendar.current
        let timestamp = TimeInterval(timeStamp)
        let dateFromTimestamp = Date(timeIntervalSince1970: timestamp)
        var daysLeft = ""

//        if let date = calendar.date(from: dateComponents), let daysDiff = calendar.dateComponents([.day], from: date, to: currentDate).day {
//            daysLeft = String(daysDiff)
//        }

        if let daysDiff = calendar.dateComponents([.day], from: dateFromTimestamp, to: currentDate).day {
            daysLeft = String(daysDiff)
        }

        return daysLeft
    }
}
