import Foundation

struct EndpointComponent {
    let path: String
    var queryItems: [String: String] = [:]

    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = path
        components.setQueryItems(with: queryItems)
        return components.url
    }
}
