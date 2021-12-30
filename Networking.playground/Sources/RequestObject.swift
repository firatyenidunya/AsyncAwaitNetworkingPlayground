import Foundation

public struct RequestObject {
    var path: String
    var httpMethod: HTTPMethod
    var parameters: [String: String]
    var headers: [String: String]

    public init(path: String,
                httpMethod: HTTPMethod = .get,
                parameters: [String: String] = [:],
                headers: [String: String] = [:]) {
        self.path = path
        self.httpMethod = httpMethod
        self.parameters = parameters
        self.headers = headers
    }
    
    private var endpoint: EndpointComponent {
        return EndpointComponent(path: path, queryItems: parameters)
    }
    
    public func getUrlRequest() throws -> URLRequest {
        guard let url = endpoint.url else {
            throw AppError.invalidUrlRequest
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.description
        urlRequest.allHTTPHeaderFields = headers
        return urlRequest
    }
}
