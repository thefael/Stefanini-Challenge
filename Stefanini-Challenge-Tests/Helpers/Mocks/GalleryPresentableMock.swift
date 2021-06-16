@testable import Stefanini_Challenge
import UIKit

class GalleryPresentableMock: GalleryPresentable {
    var presentedLinks: [String]?
    var presentedError: Error?

    func presentLinks(_ links: [String]) {
        presentedLinks = links
    }

    func presentError(_ error: Error) {
        presentedError = error
    }
}
