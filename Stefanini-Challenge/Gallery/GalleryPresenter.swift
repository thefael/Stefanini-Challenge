import Foundation

protocol GalleryPresenterType {
    func fetchGallery()
}

class GalleryPresenter: GalleryPresenterType {
    let service: FetchServiceType
    weak var presentable: GalleryPresentable?

    init(service: FetchServiceType = FetchService.shared) {
        self.service = service
    }

    func fetchGallery() {
        service.fetchData(from: Endpoints.getSearchGalleryRequest()) { (result: Result<GalleryData, FetchError>) in
            switch result {
            case .success(let galleryData):
                let links = self.getImageLinks(from: galleryData)
                self.presentable?.presentLinks(links)
            case .failure(let error):
                self.presentable?.presentError(error)
            }
        }
    }

    private func getImageLinks(from galleryData: GalleryData) -> [String] {
        return galleryData.gallery
            .flatMap { gallery in
                return gallery.post ?? []
            }
            .filter { post in
                return post.type.contains("image")
            }
            .map { $0.link }
    }
}
