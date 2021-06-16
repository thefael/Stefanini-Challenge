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
    var scrollViewDidEndScrolling = false

    override func loadView() {
        view = galleryView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Galeria de imagens"
        presenter.presentable = self
        configureCollectionView()
        configureCell()
        presenter.fetchGallery()
    }

    private func configureCollectionView() {
        galleryView.collectionView.dataSource = dataSource
        galleryView.collectionView.delegate = self
        galleryView.collectionView.register(GalleryCell.self, forCellWithReuseIdentifier: String(describing: GalleryCell.self))
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
        scrollViewDidEndScrolling = false
    }

    func presentError(_ error: Error) {
        showAlert(title: "Deu ruim, man!", message: error.localizedDescription, actionTitle: "Ok")
    }
}

extension GalleryViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height
            && scrollViewDidEndScrolling == false
            && scrollView.contentSize.height > 0 {
            scrollViewDidEndScrolling = true
            presenter.fetchGallery()
        }
    }
}
