//
//  Copyright © 2023 Vitalii Ivashchenko. All rights reserved.
//

import Foundation

protocol HTTPClient {
    func data(for request: URLRequest) async throws -> (Data, HTTPURLResponse)
}
