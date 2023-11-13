//
//  Copyright © 2023 Vitalii Ivashchenko. All rights reserved.
//

import Foundation

class GetImageMapper {
    
    public enum Error: Swift.Error, Equatable {
        case invalidStatusCode(Int)
    }
    
    // MARK: - Public methods
    public static func map(data: Data, from response: HTTPURLResponse) throws -> Data {
        guard response.statusCode == 200 else { throw Error.invalidStatusCode(response.statusCode) }
        
        return data
    }
}
