import UIKit

protocol GalleryPresentable: AnyObject {
    func presentLinks(_ links: [String])
    func presentError(_ error: Error)
}

class GalleryViewController: UIViewController {
    let galleryView = GalleryView(frame: Constants.screen)
    let presenter = GalleryPresenter()
    let imageGateway = ImageGateway()
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
            cell.fetchImage(from: self.imageGateway)
        }
    }

    private func showAlert(title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: {_ in }))
    }
}

extension GalleryViewController: GalleryPresentable {
    func presentLinks(_ links: [String]) {
        DispatchQueue.main.async {
            self.dataSource.items.append(contentsOf: links)
            self.galleryView.collectionView.reloadData()
            self.galleryView.activity.stopAnimating()
        }
    }

    func presentError(_ error: Error) {
        showAlert(title: "Deu ruim, man!", message: error.localizedDescription, actionTitle: "Ok")
    }
}
