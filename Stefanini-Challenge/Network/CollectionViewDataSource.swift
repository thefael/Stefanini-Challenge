import UIKit

class CollectionViewDataSource<T, Cell: UICollectionViewCell>: NSObject, UICollectionViewDataSource {
    var items = [T]()
    var configureCell: ((T, Cell) -> Void)?

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: Cell.self), for: indexPath) as? Cell else {
            return UICollectionViewCell()
        }
        configureCell?(item, cell)
        return cell
    }
}
