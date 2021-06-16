import UIKit

protocol ImageCompressor {
    func compress(_ image: UIImage) -> UIImage?
}

class JPEGCompressor: ImageCompressor {
    func compress(_ image: UIImage) -> UIImage? {
        image.jpeg(.lowest).flatMap(UIImage.init)
    }
}
