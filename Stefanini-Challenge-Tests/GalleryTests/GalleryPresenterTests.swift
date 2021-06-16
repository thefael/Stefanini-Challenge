@testable import Stefanini_Challenge
import XCTest

class GalleryPresenterTests: XCTestCase {
    let serviceMock = FetchServiceMock<GalleryData>()
    let presentableMock = GalleryPresentableMock()
    let galleryDataFixture = GalleryDataFixture.galleryData
    let testURL = URL(fileURLWithPath: "")
    let testImage = UIImage()
    var fetchImageResult: (Result<UIImage, FetchError>)?
    lazy var presenter = GalleryPresenter(service: serviceMock)

    func test_fetchGallery_whenResultIsSuccess_shouldCallPresentablePresentLinks_withCorrectLinks() {
        presenter.presentable = presentableMock
        presenter.fetchGallery()

        serviceMock.fetchDataArgs?.completion(.success(galleryDataFixture))

        let presentedLinks = presentableMock.presentedLinks
        XCTAssertEqual(presentedLinks, [GalleryDataFixture.post.link])
    }

    func test_fetchGallery_whenResultIsFailure_shouldCallPresentablePresentError_withCorrectError() {
        presenter.presentable = presentableMock
        presenter.fetchGallery()

        serviceMock.fetchDataArgs?.completion(.failure(.invalidData))

        let presentedError = presentableMock.presentedError
        XCTAssertEqual(presentedError as? FetchError, .invalidData)
    }
}

struct GalleryDataFixture {
    static let post = Post(id: "idFixture", type: "imageTypeFixture", link: "linkFixture")
    static let gallery = Gallery(post: [post])
    static let galleryData = GalleryData(gallery: [gallery])
}
