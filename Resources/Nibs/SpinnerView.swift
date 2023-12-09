import UIKit

class SpinnerView: UIView {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.spinner.startAnimating()
    }

}
