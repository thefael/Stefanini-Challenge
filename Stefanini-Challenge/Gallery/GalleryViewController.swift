import UIKit

class GalleryViewController: UIViewController {
    let galleryView = GalleryView()
    let presenter = GalleryPresenter()

    override func loadView() {
        view = galleryView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Galeria de imagens"
        presenter.fetchGallery()
    }
}
