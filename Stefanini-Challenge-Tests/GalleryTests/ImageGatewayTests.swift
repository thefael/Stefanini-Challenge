@testable import Stefanini_Challenge
import XCTest

class ImageGatewayTests: XCTestCase {
    let presenterMock = GalleryPresenterMock()
    let imageCacheMock = ImageCacheMock()
    let invalidURL: URL? = nil
    let testImage = UIImage()
    let testURL = URL(fileURLWithPath: "")
    lazy var imageGateway = ImageGateway(presenter: presenterMock, cache: imageCacheMock)

    var fetchImageResult: Result<UIImage, FetchError>?

    func test_fetchImage_whenURLIsInvalid_shouldReturnNilSuspendableTask() {
        let suspendableTask = imageGateway.fetchImage(from: invalidURL) { _ in }

        XCTAssertNil(suspendableTask)
    }

    func test_fetchImage_whenImageCacheHasImage_shouldCallCompletion_withcorrectImage() {
        imageCacheMock.getImageHandler = { _ in
            return self.testImage
        }

        let _ = imageGateway.fetchImage(from: testURL) { result in
            self.fetchImageResult = result
        }

        presenterMock.fetchImageArgs?.completion(.success(testImage))
        let image = try? fetchImageResult?.get()

        XCTAssertEqual(image, testImage)
    }

    func test_fetchImage_whenResultIsSuccess_shouldCallCompletion_withCorrectImage() {
        let _ = imageGateway.fetchImage(from: testURL) { result in
            self.fetchImageResult = result
        }

        presenterMock.fetchImageArgs?.completion(.success(testImage))
        let image = try? fetchImageResult?.get()

        XCTAssertEqual(image, testImage)
    }

    func test_fetchImage_whenResultIsFailure_shouldCallCompletion_withCorrectImage() {
        let _ = imageGateway.fetchImage(from: testURL) { result in
            self.fetchImageResult = result
        }

        presenterMock.fetchImageArgs?.completion(.failure(.invalidData))

        XCTAssertThrowsError(try fetchImageResult?.get()) { error in
            XCTAssertEqual(error as? FetchError, .invalidData)
        }
    }

}
