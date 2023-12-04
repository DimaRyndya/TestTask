import UIKit

final class DetailPostViewController: UIViewController {

    @IBOutlet var postImageView: UIImageView!
    @IBOutlet var postTitleLabel: UILabel!
    @IBOutlet var postTextLabel: UILabel!

    let viewModel = DetailPostViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Post Detail"
    }

}
