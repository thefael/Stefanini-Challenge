import UIKit

protocol ImageGatewayType {
    func fetchImage(from url: URL?, _ completion: @escaping ((Result<UIImage, FetchError>) -> Void)) -> SuspendableTask?
}

class ImageGateway: ImageGatewayType {
    let service: FetchServiceType
    let cache: ImageCacheType

    init(service: FetchServiceType = FetchService.shared, cache: ImageCacheType = ImageCache()) {
        self.service = service
        self.cache = cache
    }

    func fetchImage(from url: URL?, _ completion: @escaping ((Result<UIImage, FetchError>) -> Void)) -> SuspendableTask? {
        guard let url = url else { return nil }
        if let image = cache.getImage(forKey: url as NSURL) {
            completion(.success(image))
            return nil
        } else {
            let task = service.fetchImage(from: url) { result in
                switch result {
                case .success(let image):
                    self.cache.set(image: image, forKey: url as NSURL)
                    completion(.success(image))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            return task
        }
    }
}
