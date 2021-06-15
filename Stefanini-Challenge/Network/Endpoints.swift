import Foundation

enum Endpoints {
    private static var baseComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.imgur.com"
        components.path = "/3/gallery/hot/viral/day"
        components.queryItems = [
            URLQueryItem(name: "showViral", value: "true"),
            URLQueryItem(name: "mature", value: "false"),
            URLQueryItem(name: "album_previews", value: "false")
        ]
        return components
    }()

    static func galleryRequest() -> URLRequest? {
        guard let url = baseComponents.url else { return nil }
        print(url)
        var request = URLRequest(url: url)
        request.setValue("Client-ID 1ceddedc03a5d71", forHTTPHeaderField: "Authorization")
        return request
    }
}
