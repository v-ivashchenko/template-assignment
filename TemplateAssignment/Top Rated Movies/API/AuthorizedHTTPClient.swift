//
//  Copyright © 2023 Vitalii Ivashchenko. All rights reserved.
//

import Foundation

class AuthorizedHTTPClient: HTTPClient {
    
    // MARK: - Private properties
    private let client: HTTPClient
    
    // MARK: - Initialization
    init(client: HTTPClient) {
        self.client = client
    }
    
    // MARK: - Public methods
    func data(for request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        var request = request
        request.setValue("YOUR_OWN_BEARER_TOKEN", forHTTPHeaderField: "Authorization")
        
        return try await client.data(for: request)
    }
}
