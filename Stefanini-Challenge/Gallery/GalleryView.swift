import UIKit

class GalleryView: UIView {
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private let layout = UICollectionViewFlowLayout()
    lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.hidesWhenStopped = true
        activity.startAnimating()
        return activity
    }()

    override init(frame: CGRect = Constants.screen) {
        super.init(frame: frame)
        setupFlowLayout()
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupFlowLayout() {
        let width = Constants.screen.width/4
        let height = Constants.screen.height/4
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
    }

    private func setupView() {
        backgroundColor = .white
        collectionView = UICollectionView(frame: Constants.screen, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.init(red: 0.2, green: 0.7, blue: 0.4, alpha: 1)
        collectionView.backgroundView = activity
        addSubview(collectionView)

    }
}
