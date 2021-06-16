import Foundation

enum FetchError: Error {
    case failedToDecodeData
    case invalidData
    case invalidRequest
    case invalidURL
}
