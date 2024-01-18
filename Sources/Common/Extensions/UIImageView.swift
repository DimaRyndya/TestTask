import Foundation

import UIKit

extension UIImageView {
    func loadImage(url: String) {
        guard let imageURL = URL(string: url) else { return }
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: imageURL), let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.image = image
            }

        }
    }
}

