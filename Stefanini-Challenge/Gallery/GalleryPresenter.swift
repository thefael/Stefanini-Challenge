import Foundation

class GalleryPresenter {
    let service: FetchServiceType

    init(service: FetchServiceType = FetchService()) {
        self.service = service
    }

    func fetchGallery() {
        service.fetchData(from: Endpoints.galleryRequest()) { (result: Result<GalleryData, Error>) in
            switch result {
            case .success(let gallery):
                gallery.data.forEach { $0.post.forEach { print($0.link) }}
            case .failure(let error):
                print(error)
            }
        }
    }
}
