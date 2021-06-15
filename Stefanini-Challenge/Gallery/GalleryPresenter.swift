import UIKit

protocol GalleryPresenterType {
    func fetchGallery()
    func fetchImage(from url: URL?, _ completion: @escaping ((Result<UIImage, Error>) -> Void))
}

class GalleryPresenter: GalleryPresenterType {
    let service: FetchServiceType
    weak var presentable: GalleryPresentable?

    init(service: FetchServiceType = FetchService()) {
        self.service = service
    }

    func fetchGallery() {
        service.fetchData(from: Endpoints.galleryRequest()) { (result: Result<GalleryData, Error>) in
            switch result {
            case .success(let galleryData):
                var links = [String]()
                galleryData.gallery.forEach { $0.post?.forEach { links.append($0.link) }}
                self.presentable?.presentLinks(links)
            case .failure(let error):
                self.presentable?.presentError(error)
            }
        }
    }

    func fetchImage(from url: URL?, _ completion: @escaping ((Result<UIImage, Error>) -> Void)) {
        service.fetchImage(from: url) { result in
            switch result {
            case .success(let image):
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
