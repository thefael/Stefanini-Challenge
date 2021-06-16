@testable import Stefanini_Challenge
import XCTest

class FetchServiceTests: XCTestCase {
    let sessionMock = URLSessionAdapterMock()
    let testURL = URL(fileURLWithPath: "")
    lazy var testRequest = URLRequest(url: testURL)
    lazy var fetchService = FetchService(session: sessionMock)

    var fetchDataResult: Result<JSONObject, FetchError>?
    var fetchImageResult: Result<UIImage, FetchError>?
    
    func test_fetchData_whenResultIsSuccess_shouldCallCompletionWithCorrectObject() {
        guard let testData = JSONObject().data else {
            XCTFail()
            return
        }

        fetchService.fetchData(from: testRequest) { result in
            self.fetchDataResult = result
        }

        sessionMock.fetchDataArgs?.completion(.success(testData))

        let decodedData = JSONObject()
        let object = try? fetchDataResult?.get()

        XCTAssertEqual(object, decodedData)
    }
    
    func test_fetchData_whenResultIsFailure_shouldCallCompletionWithCorrectError() {
        fetchService.fetchData(from: testRequest) { result in
            self.fetchDataResult = result
        }

        sessionMock.fetchDataArgs?.completion(.failure(.invalidData))

        XCTAssertThrowsError(try fetchDataResult?.get()) { error in
            XCTAssertEqual(error as? FetchError, .invalidData)
        }
    }

    func test_fetchData_whenDecodeFails_shouldCallCompletionWithCorrectError() {
        let invalidData = Data()
        fetchService.fetchData(from: testRequest) { result in
            self.fetchDataResult = result
        }

        sessionMock.fetchDataArgs?.completion(.success(invalidData))

        XCTAssertThrowsError(try fetchDataResult?.get()) { error in
            XCTAssertEqual(error as? FetchError, .failedToDecodeData)
        }
    }

    func test_fetchData_whenRequestIsInvalid_shouldCallCompletionWithCorrectError() {
        let invalidRequest: URLRequest? = nil
        fetchService.fetchData(from: invalidRequest) { result in
            self.fetchDataResult = result
        }

        sessionMock.fetchDataArgs?.completion(.failure(.invalidRequest))

        XCTAssertThrowsError(try fetchDataResult?.get()) { error in
            XCTAssertEqual(error as? FetchError, .invalidRequest)
        }
    }

    func test_fetchImage_whenResultIsSuccess_shouldCallCompletionWithCorrectImage() {
        let _ = fetchService.fetchImage(from: testURL) { result in
            self.fetchImageResult = result
        }
        let validImage = UIImage()

        sessionMock.fetchImageArgs?.completion(.success(validImage))

        let image = try? fetchImageResult?.get()

        XCTAssertEqual(image, validImage)
    }

    func test_fetchImage_whenResultIsFailure_shouldCallCompletionWithCorrectError() {
        let _ = fetchService.fetchImage(from: testURL) { result in
            self.fetchImageResult = result
        }

        sessionMock.fetchImageArgs?.completion(.failure(.invalidData))

        XCTAssertThrowsError(try fetchImageResult?.get()) { error in
            XCTAssertEqual(error as? FetchError, .invalidData)
        }
    }

    func test_fetchImage_whenURLIsInvalid_shouldCallCompletionWithCorrectError() {
        let invalidURL: URL? = nil
        let _ = fetchService.fetchImage(from: invalidURL) { result in
            self.fetchImageResult = result
        }

        sessionMock.fetchImageArgs?.completion(.failure(.invalidURL))

        XCTAssertThrowsError(try fetchImageResult?.get()) { error in
            XCTAssertEqual(error as? FetchError, .invalidURL)
        }
    }
}
