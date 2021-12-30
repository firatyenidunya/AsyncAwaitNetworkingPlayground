import Foundation

extension HTTPURLResponse {
    var httpStatus: HTTPStatus? {
        HTTPStatus(rawValue: statusCode)
    }
}
