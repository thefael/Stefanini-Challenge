import Foundation

enum Endpoints {
    private static var baseComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.imgur.com"
        components.path = "/3/gallery"

        return components
    }()

    static func galleryRequest() -> URLRequest? {
        var components = baseComponents
        components.queryItems = [
            URLQueryItem(name: "showViral", value: "true"),
            URLQueryItem(name: "mature", value: "false"),
            URLQueryItem(name: "album_previews", value: "false")
        ]
        guard var url = components.url else { return nil }
        url.appendPathComponent("/hot/viral/day")
        
        var request = URLRequest(url: url)
        request.setValue("Client-ID 1ceddedc03a5d71", forHTTPHeaderField: "Authorization")
        return request
    }

    static func searchGalleryRequest() -> URLRequest? {
        var components = baseComponents
        components.queryItems = [
            URLQueryItem(name: "q", value: "cats")
        ]
        guard var url = components.url else { return nil }
        url.appendPathComponent("/search/top/week")

        var request = URLRequest(url: url)
        request.setValue("Client-ID 1ceddedc03a5d71", forHTTPHeaderField: "Authorization")
        return request
    }
}
