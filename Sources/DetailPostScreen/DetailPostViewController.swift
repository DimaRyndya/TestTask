import UIKit

class DetailPostViewController: UIViewController {

    @IBOutlet var postImageView: UIImageView!
    @IBOutlet var postTitleLabel: UILabel!
    @IBOutlet var postTextLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Post Detail"
    }

}
