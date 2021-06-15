import UIKit

class GalleryViewController: UIViewController {
    let galleryView = GalleryView()

    override func loadView() {
        view = galleryView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Galeria de imagens"
    }


}

