import UIKit

protocol FetchServiceType {
    func fetchData<T: Decodable>(from request: URLRequest?, completion: @escaping ((Result<T, FetchError>) -> Void))
    func fetchImage(from url: URL?, completion: @escaping ((Result<UIImage, FetchError>) -> Void)) -> SuspendableTask?
}

class FetchService: FetchServiceType {
    let session: URLSessionAdaptable
    let decoder: JSONDecoder
    static let shared = FetchService()

    init(session: URLSessionAdaptable = URLSessionAdapter(), decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }

    func fetchData<T: Decodable>(from request: URLRequest?, completion: @escaping ((Result<T, FetchError>) -> Void)) {
        guard let request = request else { completion(.failure(.invalidRequest)); return }
        session.fetchData(request: request) { result in
            switch result {
            case .success(let data):
                do {
                    let model = try self.decoder.decode(T.self, from: data)
                    completion(.success(model))
                } catch { completion(.failure(.failedToDecodeData)) }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchImage(from url: URL?, completion: @escaping ((Result<UIImage, FetchError>) -> Void)) -> SuspendableTask? {
        guard let url = url else { completion(.failure(.invalidURL)); return nil }
        let task = session.fetchImage(from: url) { result in
            switch result {
            case .success(let image):
                guard let newImage = image.jpeg(.lowest).flatMap(UIImage.init) else { return }
                completion(.success(newImage))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return task
    }
}
