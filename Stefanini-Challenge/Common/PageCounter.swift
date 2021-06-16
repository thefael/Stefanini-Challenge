import Foundation

enum PageCounter {
    private static var pageNumber = 0
    static func getPageNumber() -> Int {
        pageNumber += 1
        return pageNumber
    }
}
