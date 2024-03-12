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
        request.setValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNGYwMmQwMWQ4Y2FhNDhkY2Y0NTU4NmNjOWJhOTIwMSIsInN1YiI6IjY1NGZkNDRkNjdiNjEzMDBjODRiNzg0NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.yyZIdrsV1NDZPL9lHdQdQenL007bfe4IOCeZQR4AMLw", forHTTPHeaderField: "Authorization")
        
        return try await client.data(for: request)
    }
}
