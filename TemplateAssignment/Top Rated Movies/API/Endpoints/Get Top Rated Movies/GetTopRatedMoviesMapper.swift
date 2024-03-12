//
//  Copyright © 2023 Vitalii Ivashchenko. All rights reserved.
//

import Foundation

class GetTopRatedMoviesMapper {
    
    struct Response: Decodable {
        let results: [Movie]
    }
    
    struct Movie: Decodable {
        let title: String
        let voteAverage: Double
        let posterPath: String
    }
    
    public enum Error: Swift.Error, Equatable {
        case invalidStatusCode(Int)
    }
    
    // MARK: - Public methods
    public static func map(data: Data, from response: HTTPURLResponse) throws -> Response {
        guard response.statusCode == 200 else { throw Error.invalidStatusCode(response.statusCode) }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode(Response.self, from: data)
    }
}
