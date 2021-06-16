import UIKit

protocol URLSessionAdaptable {
    func fetchData(request: URLRequest, completion: @escaping (Result<Data, FetchError>) -> Void)
    func fetchImage(from url: URL, completion: @escaping ((Result<UIImage, FetchError>) -> Void)) -> SuspendableTask
}

class URLSessionAdapter: URLSessionAdaptable {
    let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchData(request: URLRequest, completion: @escaping (Result<Data, FetchError>) -> Void) {
        session.dataTask(with: request) { data, _, _ in
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(.invalidData))
            }
        }.resume()
    }

    func fetchImage(from url: URL, completion: @escaping ((Result<UIImage, FetchError>) -> Void)) -> SuspendableTask {
        let imageTask = session.dataTask(with: url) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                completion(.failure(.invalidData))
            }
        }
        imageTask.resume()

        return SuspendableDataTask(task: imageTask)
    }
}
