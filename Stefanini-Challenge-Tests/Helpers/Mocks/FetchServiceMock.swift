@testable import Stefanini_Challenge
import UIKit

class FetchServiceMock<U: Decodable>: FetchServiceType {
    var fetchDataArgs: (request: URLRequest?, completion: (Result<U, FetchError>) -> Void)?
    var fetchImageArgs: (url: URL?, completion: (Result<UIImage, FetchError>) -> Void)?

    func fetchData<T>(from request: URLRequest?, completion: @escaping ((Result<T, FetchError>) -> Void)) where T : Decodable {
        guard let completion = completion as? (Result<U, FetchError>) -> Void else { return }
        fetchDataArgs = (request: request, completion: completion)
    }

    func fetchImage(from url: URL?, completion: @escaping ((Result<UIImage, FetchError>) -> Void)) -> SuspendableTask? {
        fetchImageArgs = (url: url, completion: completion)
        return nil
    }
}
