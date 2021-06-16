@testable import Stefanini_Challenge
import XCTest

class ImageCacheTests: XCTestCase {
    let testCache = NSCache<NSURL, UIImage>()
    let testImage = UIImage()
    let testKey = NSURL(string: "testKey")!
    lazy var imageCache = ImageCache(cache: testCache)

    func test_setImage_shouldSetImageIntoCache() {
        imageCache.set(image: testImage, forKey: testKey)

        let image = testCache.object(forKey: testKey)

        XCTAssertEqual(image, testImage)
    }

    func test_getImage_shouldGetImageFromCache() {
        testCache.setObject(testImage, forKey: testKey)

        let image = imageCache.getImage(forKey: testKey)

        XCTAssertEqual(image, testImage)
    }
}
