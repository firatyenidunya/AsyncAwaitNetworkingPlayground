import Foundation

public protocol BaseServiceProtocol {
    func request<T: Decodable>(with requestObject: RequestObject,
                               decoder: JSONDecoder) async throws -> T
}

public final class BaseService: NSObject, BaseServiceProtocol {
    
    var urlSession: NetworkLoader
    
    public init(urlSession: NetworkLoader = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    public func request<T: Decodable>(with requestObject: RequestObject,
                                      decoder: JSONDecoder) async throws -> T {
        let urlRequest = try requestObject.getUrlRequest()
        let (data, response) = try await urlSession.dataTask(for: urlRequest, delegate: self)
        return try handle(response, with: decoder, with: data)
    }
    
    private func handle<T: Decodable>(_ response: URLResponse?,
                                      with decoder: JSONDecoder,
                                      with data: Data?) throws -> T {
        guard let httpData = data else {
            if let response = response as? HTTPURLResponse,
               let httpStatus = response.httpStatus, !httpStatus.httpStatusType.isSuccess {
                throw AppError.httpError(status: httpStatus)
            }
            throw AppError.badResponse
        }
        
        do {
            return try decoder.decode(T.self, from: httpData)
        } catch DecodingError.keyNotFound {
            throw AppError.mappingFailed
        } catch {
            throw AppError.unknown(error: error as NSError)
        }
    }
}

extension BaseService: URLSessionTaskDelegate { }
