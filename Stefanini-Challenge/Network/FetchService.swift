import UIKit

protocol FetchServiceType {
    func fetchData<T: Decodable>(from request: URLRequest?, completion: @escaping ((Result<T, Error>) -> Void))
    func fetchImage(from url: URL?, completion: @escaping ((Result<UIImage, Error>) -> Void))
}

class FetchService: FetchServiceType {
    let session: URLSession
    let decoder: JSONDecoder

    init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }

    func fetchData<T: Decodable>(from request: URLRequest?, completion: @escaping ((Result<T, Error>) -> Void)) {
        guard let request = request else { return }
        session.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let model = try self.decoder.decode(T.self, from: data)
                    completion(.success(model))
                } catch let error { completion(.failure(error)) }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchImage(from url: URL?, completion: @escaping ((Result<UIImage, Error>) -> Void)) {
        guard let url = url else { return }
        session.dataTask(with: url) { data, _, error in
            if let data = data, let image = UIImage(data: data) {
                completion(.success(image))
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
}
