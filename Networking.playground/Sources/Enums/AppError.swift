import Foundation

enum AppError: Error {
    case invalidUrlRequest
    case httpError(status: HTTPStatus)
    case unknown(error: NSError)
    case badResponse
    case mappingFailed

    var errorCode: Int {
        switch self {
            case .httpError(let error):
                return error.rawValue
            case .unknown(let error):
                return error.code
            case .mappingFailed, .badResponse, .invalidUrlRequest:
                return 0
        }
    }
}
