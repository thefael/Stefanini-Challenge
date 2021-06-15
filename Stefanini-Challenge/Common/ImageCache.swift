import UIKit

protocol ImageCacheType {
    func set(image: UIImage, forKey key: NSURL)
    func getImage(forKey key: NSURL) -> UIImage?
}

class ImageCache: ImageCacheType {
    private var cache: NSCache<NSURL, UIImage>

    init(cache: NSCache<NSURL, UIImage> = NSCache<NSURL, UIImage>()) {
        self.cache = cache
    }

    func set(image: UIImage, forKey key: NSURL) {
        cache.setObject(image, forKey: key)
    }

    func getImage(forKey key: NSURL) -> UIImage? {
        return cache.object(forKey: key)
    }
}
