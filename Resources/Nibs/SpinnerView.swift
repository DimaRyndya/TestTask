import UIKit

class SpinnerView: UIView {

    // MARK: - Outlets

    @IBOutlet weak var spinner: UIActivityIndicatorView!

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        self.spinner.startAnimating()
    }

}
