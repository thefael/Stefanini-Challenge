import Foundation

struct GalleryData: Decodable {
    let data: [Gallery]
}

struct Gallery: Decodable {
    let post: [Post]

    enum CodingKeys: String, CodingKey {
        case post = "images"
    }
}

struct Post: Decodable {
    let id: String
    let link: String
}

