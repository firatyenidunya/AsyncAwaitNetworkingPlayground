import Foundation

extension URLSession: NetworkLoader {
    public func dataTask(for request: URLRequest,
                         delegate: URLSessionTaskDelegate? = nil) async throws -> (Data, URLResponse) {
        try await self.data(for: request, delegate: delegate)
    }
}
