import UIKit

final class DetailPostViewController: UIViewController {

    @IBOutlet var postImageView: UIImageView!
    @IBOutlet var postTitleLabel: UILabel!
    @IBOutlet var postTextLabel: UILabel!


    let viewModel = DetailPostViewModel()
    let spinnerView = Bundle.main.loadNibNamed("SpinnerView", owner: DetailPostViewController.self, options: nil)![0] as? SpinnerView

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Preview"
    }

    func changeUI(for state: DetailPostViewModel.State) {
        switch state {
        case .loading:
            view.addSubview(spinnerView ?? UIView())
        case .foundPost:
            postTitleLabel.text = viewModel.postTitle
            postTextLabel.text = viewModel.postText
            postImageView.loadImage(url: viewModel.imageURL)
            spinnerView?.removeFromSuperview()
        }
    }
}
