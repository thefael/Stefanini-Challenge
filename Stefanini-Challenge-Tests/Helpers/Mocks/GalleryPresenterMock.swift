@testable import Stefanini_Challenge
import UIKit

class GalleryPresenterMock: GalleryPresenterType {
    var didCallFetchGallery = false
    var fetchImageArgs: (url: URL?, completion: (Result<UIImage, FetchError>) -> Void)?

    func fetchGallery() {
        didCallFetchGallery = true
    }

    func fetchImage(from url: URL?, _ completion: @escaping ((Result<UIImage, FetchError>) -> Void)) -> SuspendableTask? {
        fetchImageArgs = (url: url, completion: completion)
        return nil
    }


}
