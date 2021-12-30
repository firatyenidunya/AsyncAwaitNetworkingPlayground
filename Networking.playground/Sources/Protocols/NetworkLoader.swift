import Foundation

public protocol NetworkLoader {
    func dataTask(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}
