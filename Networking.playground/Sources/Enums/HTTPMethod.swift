import Foundation

public enum HTTPMethod: String, CustomStringConvertible {
    case get
    case post
    case put
    case delete

    public var description: String {
        rawValue.uppercased()
    }
}
