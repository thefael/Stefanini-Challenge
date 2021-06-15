import UIKit

protocol FetchServiceType {
    func fetchData<T: Decodable>(from request: URLRequest?, completion: @escaping ((Result<T, FetchError>) -> Void))
    func fetchImage(from url: URL?, completion: @escaping ((Result<UIImage, FetchError>) -> Void)) -> URLSessionDataTask?
}

class FetchService: FetchServiceType {
    let session: URLSession
    let decoder: JSONDecoder

    init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }

    func fetchData<T: Decodable>(from request: URLRequest?, completion: @escaping ((Result<T, FetchError>) -> Void)) {
        guard let request = request else { completion(.failure(.invalidRequest)); return }
        session.dataTask(with: request) { data, _, _ in
            if let data = data {
                do {
                    let model = try self.decoder.decode(T.self, from: data)
                    completion(.success(model))
                } catch { completion(.failure(.failedToDecodeData)) }
            } else {
                completion(.failure(.invalidData))
            }
        }.resume()
    }

    func fetchImage(from url: URL?, completion: @escaping ((Result<UIImage, FetchError>) -> Void)) -> URLSessionDataTask? {
        guard let url = url else { completion(.failure(.invalidURL)); return nil }
        let dataTask = session.dataTask(with: url) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                completion(.failure(.failedToDecodeData))
            }
        }
        dataTask.resume()
        return dataTask
    }
}
