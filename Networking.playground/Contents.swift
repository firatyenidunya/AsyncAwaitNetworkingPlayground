import Foundation
import Networking_Sources
import UIKit

struct ExampleResponse: Decodable {
    var bio: String
}

func bar() async throws -> ExampleResponse {
    let baseService: BaseServiceProtocol = BaseService()
    return try await baseService.request(with: RequestObject(path: "/users/defunkt"), decoder: JSONDecoder())
}

Task {
    do {
        let foo = try await bar()
        print(foo.bio)
    } catch {
        print(error)
    }
}
