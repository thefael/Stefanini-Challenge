import Foundation

struct GalleryData: Decodable {
    let gallery: [Gallery]

    enum CodingKeys: String, CodingKey {
        case gallery = "data"
    }
}

struct Gallery: Decodable {
    let post: [Post]?

    enum CodingKeys: String, CodingKey {
        case post = "images"
    }
}

struct Post: Decodable {
    let id: String
    let type: String
    let link: String
}

