import Foundation

import UIKit

extension UIImageView {
    
    func loadImage(url: String) {
        guard let imageURL = URL(string: url) else { return }
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: imageURL) else { return }
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}

