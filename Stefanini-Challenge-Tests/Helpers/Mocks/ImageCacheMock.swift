@testable import Stefanini_Challenge
import UIKit

class ImageCacheMock: ImageCacheType {
    var didCallSet = false
    var didCallGetImage = true
    var getImageHandler: ((NSURL) -> UIImage?)?

    func set(image: UIImage, forKey key: NSURL) {
        didCallSet = true
    }

    func getImage(forKey key: NSURL) -> UIImage? {
        getImageHandler?(key)
    }
}
