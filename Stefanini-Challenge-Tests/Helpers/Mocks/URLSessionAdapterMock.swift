@testable import Stefanini_Challenge
import UIKit

class URLSessionAdapterMock: URLSessionAdaptable {
    var fetchDataArgs: (request: URLRequest, completion: (Result<Data, FetchError>) -> Void)?
    var fetchImageArgs: (url: URL, completion: (Result<UIImage, FetchError>) -> Void)?

    func fetchData(request: URLRequest, completion: @escaping (Result<Data, FetchError>) -> Void) {
        fetchDataArgs = (request, completion)
    }

    func fetchImage(from url: URL, completion: @escaping ((Result<UIImage, FetchError>) -> Void)) -> SuspendableTask? {
        fetchImageArgs = (url, completion)
        return nil
    }
}
