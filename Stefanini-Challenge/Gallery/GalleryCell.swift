import UIKit

class GalleryCell: UICollectionViewCell {
    let imageView = UIImageView()
    var imageLink: String?
    var imageTask: SuspendableTask?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }

    func fetchImage(from imageGateway: ImageGateway) {
        guard let link = imageLink, let url = URL(string: link) else { return }
        imageTask = imageGateway.fetchImage(from: url) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            case .failure(let error):
                print("Erro no cell.fetchImage: \(error)")
            }
        }
    }

    override func prepareForReuse() {
        DispatchQueue.main.async {
            self.imageView.image = nil
        }
        imageTask?.suspend()
    }
}
