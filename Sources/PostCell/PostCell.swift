import UIKit

protocol PostCellDelegate: AnyObject {
    func postCellDidChangeHeight(_ cell: PostCell)
}

final class PostCell: UITableViewCell {
    
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var postLikesLabel: UILabel!
    @IBOutlet weak var postTimeLabel: UILabel!
    @IBOutlet weak var expandableContentStackView: UIStackView!
    
    weak var delegate: PostCellDelegate?

    var post: PostModel?

    private lazy var expandButton: UIButton = {
        let button = UIButton()
        let action = UIAction { [weak self] _ in
            self?.primaryButtonTapped()
        }
        
        button.addAction(action, for: .primaryActionTriggered)
        button.backgroundColor = .gray
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 30)
        ])

        return button
    }()

    // MARK: - Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
        post = nil
        expandableContentStackView.removeArrangedSubview(expandButton)
    }

    func configure(with post: PostModel) {
        self.post = post
        postTitleLabel.text = post.title
        postTextLabel.text = post.text
        postLikesLabel.text = String(post.likes)
        postTimeLabel.text = formatToDays(interval: post.timestamp)

        if post.numberOfLines > 2 {
            expandableContentStackView.addArrangedSubview(expandButton)
        }

        configureExpandedState()
    }

    private func configureExpandedState() {
        if post?.isExpanded == true {
            postTextLabel.numberOfLines = 0
            expandButton.setTitle("Collapse", for: .normal)
        } else {
            postTextLabel.numberOfLines = 2
            expandButton.setTitle("Expand", for: .normal)
        }
    }

    private func primaryButtonTapped() {
        post?.isExpanded.toggle()
        configureExpandedState()

        delegate?.postCellDidChangeHeight(self)
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
}
