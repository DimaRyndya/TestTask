import UIKit

// MARK: - ViewController

final class PostDetailsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var postImageView: UIImageView!
    @IBOutlet var postTitleLabel: UILabel!
    @IBOutlet var postTextLabel: UILabel!
    @IBOutlet var postLikesLabel: UILabel!
    @IBOutlet var postDateLabel: UILabel!

    // MARK: - Properties

    var viewModel: PostDetailsViewModel!
    let spinnerView = Bundle.main.loadNibNamed("SpinnerView", owner: PostDetailsViewController.self, options: nil)![0] as? SpinnerView
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postImageView.layer.cornerRadius = 10
        title = "Detail Post"
    }
    
    // MARK: - Public methods
    
    func changeUI(for state: PostDetailsViewModel.State) {
        switch state {
        case .loading:
            view.addSubview(spinnerView ?? UIView())
        case .foundPost:
            configurePost(with: viewModel.postModel)
            spinnerView?.removeFromSuperview()
        }
    }

    func configurePost(with postModel: PostDetailsModel) {
        postImageView.loadImage(url: postModel.imageURL)
        postTitleLabel.text = postModel.title
        postTextLabel.text = postModel.text
        postLikesLabel.text = postModel.likes
        postDateLabel.text = viewModel.getPostDate(from: postModel.timestamp ?? 0)
    }
}
