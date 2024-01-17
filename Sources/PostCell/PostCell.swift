import UIKit

// MARK: - Protocols

protocol PostCellDelegate: AnyObject {
    func postCellDidChangeHeight(_ cell: PostCell)
}

final class PostCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var postTitleLabel: UILabel!
    @IBOutlet private weak var postTextLabel: UILabel!
    @IBOutlet private weak var postLikesLabel: UILabel!
    @IBOutlet private weak var postTimeLabel: UILabel!
    @IBOutlet private weak var expandButton: UIButton!
    
    // MARK: - Properties
    
    weak var delegate: PostCellDelegate?
    
    private var post: PostModel?
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        expandButton.layer.cornerRadius = 5
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        post = nil
        
    }
    
    // MARK: - IBAction methods
    
    @IBAction func expandButtonTapped(_ sender: Any) {
        post?.isExpanded.toggle()
        configureExpandedState()
        
        delegate?.postCellDidChangeHeight(self)
    }
    
    // MARK: - Public methods
    
    func configure(with post: PostModel) {
        self.post = post
        postTitleLabel.text = post.title
        postTextLabel.text = post.text
        postLikesLabel.text = String(post.likes)
        postTimeLabel.text = formatToDays(interval: post.timestamp)
        expandButton.isHidden = post.numberOfLines <= 2
        
        configureExpandedState()
    }
    
    // MARK: - Private methods
    
    private func configureExpandedState() {
        if post?.isExpanded == true {
            postTextLabel.numberOfLines = 0
            expandButton.setTitle("Collapse", for: .normal)
        } else {
            postTextLabel.numberOfLines = 2
            expandButton.setTitle("Expand", for: .normal)
        }
    }
    
    private func formatToDays(interval: Int) -> String {
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
}
