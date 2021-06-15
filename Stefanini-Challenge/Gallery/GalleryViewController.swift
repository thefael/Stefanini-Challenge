import UIKit

protocol GalleryPresentable: AnyObject {
    func presentLinks(_ links: [String])
    func presentError(_ error: Error)
}

class GalleryViewController: UIViewController {
    let galleryView = GalleryView(frame: Constants.screen)
    let presenter = GalleryPresenter()
    let dataSource = CollectionViewDataSource<String, GalleryCell>()

    override func loadView() {
        view = galleryView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Galeria de imagens"
        presenter.presentable = self
        galleryView.collectionView.dataSource = dataSource
        galleryView.collectionView.register(GalleryCell.self, forCellWithReuseIdentifier: String(describing: GalleryCell.self))
        configureCell()
        presenter.fetchGallery()
    }

    private func configureCell() {
        dataSource.configureCell = { url, cell in
            cell.imageLink = url
        }
    }
}

extension GalleryViewController: GalleryPresentable {
    func presentLinks(_ links: [String]) {
        DispatchQueue.main.async {
            self.dataSource.items = links
            self.galleryView.collectionView.reloadData()
        }
    }

    func presentError(_ error: Error) {
        print(error)
    }
}
