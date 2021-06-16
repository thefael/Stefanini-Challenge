@testable import Stefanini_Challenge
import UIKit

class ImageCompressorMock: ImageCompressor {
    func compress(_ image: UIImage) -> UIImage? {
        image
    }
}
