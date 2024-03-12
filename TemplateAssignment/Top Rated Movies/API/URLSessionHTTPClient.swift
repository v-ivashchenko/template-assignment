//
//  Copyright © 2023 Vitalii Ivashchenko. All rights reserved.
//

import Foundation

class URLSessionHTTPClient: HTTPClient {
    
    // MARK: - Private properties
    private let session: URLSession
    
    // MARK: - Initialization
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - Public methods
    func data(for request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        let (data, response) = try await session.data(for: request)
        guard let response = response as? HTTPURLResponse else {
            throw NSError(domain: Bundle.main.bundleIdentifier ?? "", code: -1)
        }
        
        return (data, response)
    }
}
