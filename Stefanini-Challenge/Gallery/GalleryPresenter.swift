import UIKit

protocol GalleryPresenterType {
    func fetchGallery()
    func fetchImage(from url: URL?, _ completion: @escaping ((Result<UIImage, FetchError>) -> Void)) -> URLSessionDataTask?
}

class GalleryPresenter: GalleryPresenterType {
    let service: FetchServiceType
    weak var presentable: GalleryPresentable?

    init(service: FetchServiceType = FetchService()) {
        self.service = service
    }

    func fetchGallery() {
        service.fetchData(from: Endpoints.searchGalleryRequest()) { (result: Result<GalleryData, FetchError>) in
            switch result {
            case .success(let galleryData):
                let links = self.getImageLinks(from: galleryData)
                self.presentable?.presentLinks(links)
            case .failure(let error):
                self.presentable?.presentError(error)
            }
        }
    }

    func fetchImage(from url: URL?, _ completion: @escaping ((Result<UIImage, FetchError>) -> Void)) -> URLSessionDataTask? {
        let dataTask = service.fetchImage(from: url) { result in
            switch result {
            case .success(let image):
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return dataTask
    }

    private func getImageLinks(from galleryData: GalleryData) -> [String] {
        var links = [String]()
        galleryData.gallery.forEach { $0.post?.forEach { post in
            if post.type.contains("image") {
                links.append(post.link)
            }
        }}
        return links
    }
}
